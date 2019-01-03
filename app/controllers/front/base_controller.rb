require 'uri'

class Front::BaseController < ApplicationController
	# include SessionHelper
	layout 'front'
	before_action :maintenance_mode?

	def zip_search
		zip_list = ZipList.zip_find(zip: params[:zip])
		render json: zip_list
	rescue => e
		p e
		head 500
	end

	def authenticate!
		if session[:destination_id].present?
			if  @destination = Destination.custom_find_by(id: session[:destination_id])
			else
				flash.now[:alert] = '目的地を設定して下さい'
				redirect_to new_destination_path
			end
		else
			redirect_to new_destination_path
		end
	end

	protected

	def set_seo
		action_locales = t(action_name, scope:[:views, :front, controller_name, :actions], raise: true)rescue false

		unless action_locales
			action_locales = t(:default, scope:[:views, :front, controller_name, :actions, :default], default: {seo_title_head:'tourism', seo_description_head:'tourism '})
		end

		if action_locales[:use_argument_in_seo] # 引数あり
			case action_locales[:use_argument_in_seo]
				when 'seminar'
					arg = @seminar.title
				when 'society'
					arg = @society.title
				when 'article'
					arg = @article.title
			end
			seo_title_head = t(:seo_title_head, scope:[:views, :front, controller_name, :actions, action_name],arg: arg)rescue ''
			seo_description_head = t(:seo_description_head, scope:[:views, :front, controller_name, :actions, action_name],arg: arg)rescue ''
		else # 引数なし
			seo_title_head,seo_description_head = action_locales[:seo_title_head],action_locales[:seo_description_head]
		end

		@seo_title = "#{seo_title_head} | tourism"
		@seo_description = "#{seo_description_head}tourism"
	end

	def require_login
		redirect_to account_login_path unless login_user
	end

	def maintenance_mode?
		if MAINTE_MODE
			unless MAINTE_ALLOW_IP.include?(request.remote_ip)
				return redirect_to("/maintenance")
			end
		end
		return redirect_to('/maintenance') if MAINTE_MODE && !MAINTE_ALLOW_IP.include?(request.remote_ip)
	end

	def login_user
		if session[:user_id]
			@login_user = User.alive_records.find_by(id: session[:user_id])&.decorate
		else
			if @login_user = auth_remember_token # 自動ログイン
				session[:user_id] = @login_user.id
			end
		end
	end

end