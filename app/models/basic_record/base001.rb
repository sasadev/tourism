class BasicRecord::Base001 < ActiveRecord::Base
	#include AttrTypecastable

	require 'csv'
	require 'nkf'
	require 'unf'
	require 'kconv'

	self.abstract_class = true

	include ActionView::Helpers::NumberHelper
	include HtmlTagHelper

	def exists_db?
		self.class.exists?(id)
	end

	def join_zip
		"#{zip}"
	end
	def join_tel
		"#{tel}"
	end
	def soft_delete
		self.available  = self.class._unavailable_ if respond_to?(:available)
		self.deleted    = self.class._deleted_ if respond_to?(:deleted)

		save(validate: false)
	end
	def all_destroy
		soft_delete
	end
	def t(trans)
		self.class.t(trans)
	end

	def error_message(attribute,opt={})
		self.class.error_message(self,attribute,opt)
	end

	def available?()      available.to_i == self.class._available_ end
	def available_human() available? ? "◯" : "×" end
	def available_human_html() self.class.human_html(available_human) end

	def deleted?()      deleted != self.class._alive_at_ end
	def deleted_human() deleted? ? "" : t("admin.misc.remove") end

	def alive?()      deleted.to_i == self.class._alive_ end

	def mode_include?() include_count.to_i != 0;end
	def boolean_human(attribute)
		case self.send(attribute).to_i
			when 0 then "×"
			when 1 then "◯"
			else
				""
		end
	end

	def sex_female?()  sex.to_i == self.class.sex_female[:id];end
	def sex_male?()    sex.to_i == self.class.sex_male[:id];end
	def sex_unknown?() sex.to_i == self.class.sex_unknown[:id];end

	def sex_human
		case sex.to_i
			when self.class.sex_female[:id] then self.class.sex_female[:name]
			when self.class.sex_male[:id] then self.class.sex_male[:name]
			when self.class.sex_unknown[:id] then self.class.sex_unknown[:name]
			else "-"
		end
	end



	def generate_hashed_password
		self.salt = self.class.new_salt if self.salt.blank?
		self.hashed_password = self.class.hash_password(self.password, self.salt, self.class.auth_magic) if self.password.present?
	end

	def error_messages_for(attribute)
		errors.full_messages_for(attribute).join(',')
	end


	def mkdir_p_(dir_path)
		self.class.mkdir_p_(dir_path)
	end

	def split_zip
		zip[0..2].to_s + "-" + zip[3..6]
	end

	def address_copy(_address)
		self.class.address_sym.each do |sym|
			_address[sym] = self[sym]
		end
		return _address

	end

	def object_dump(tmp_object=nil)
		if tmp_object
			tmp_object = self[tmp_object] if tmp_object.is_a?(String)
		end
		self.class.object_dump(tmp_object || self)
	end
	def object_load(tmp_object=nil)
		if tmp_object
			tmp_object = self[tmp_object] if tmp_object.is_a?(String)
		end
		self.class.object_load(tmp_object || self)
	end

	# moved below to core_ext/time.rb
	#
	# def strftime_at(sym,sep=" ")
	# 	self[sym].try(:strftime,"%Y-%m-%d#{sep}%H:%M:%S").to_s.html_safe
	# end
	#
	# moved above to core_ext/time.rb

	def  text_sub_html(sym)
		self[sym].to_s.gsub("\n","<br/>").html_safe
	end

	def space_remove_name
		self.first_name = self.first_name.gsub(/( |　)+/, '')
		self.family_name = self.family_name.gsub(/( |　)+/, '')
		self.first_name_kana = self.first_name_kana.gsub(/( |　)+/, '')
		self.family_name_kana = self.family_name_kana.gsub(/( |　)+/, '')

		self
	end
	class << self

		def permit_params
			column_names + [
					:_destroy

			]

		end
		def object_dump(tmp_object)
			Base64.encode64(Marshal.dump(tmp_object))
		end
		def object_load(tmp_object)
			Marshal.load(Base64.decode64(tmp_object))
		end

		def custom_find_by(opt={},attr={})
			object =  self.find_obfuscated(opt[:id])
			object.attributes = attr || {}
			object
		end
		def t(trans)
			I18n.t(trans)
		end

		def belongs_to_active_model(*args)
			args.each do |name|
				define_method(name) {
					name.to_s.classify.constantize.find( self.send("#{name}_id") )
				}
			end
		end

		def has_many_active_model(*args)
			args.each do |name|
				define_method(name) {
					name.to_s.classify.constantize.where(id: self.send("#{name}_id") )
				}
			end
		end
		def _alive_at__alive_()     0; end
		def _deleted_()   1; end

		def _unavailable_() 0; end
		def _available_()   1; end

		def _alive_at_()  nil; end
		def _deleted_()  'deleted IS NOT NULL'; end
		def available_choices
			[["表示",_available_],["非表示",_unavailable_]]
		end

		def unavailable_records
			where(available: _unavailable_,deleted: _alive_at_)
		end
		def available_record(opt={})
			find_by(opt.merge({available: _available_,deleted: _alive_at_}))
		end

		def available_records
			where(available: _available_,deleted: _alive_at_)
		end

		def deleted_records
			where(_deleted_)
		end

		def published_records
			where(is_published: true,deleted: _alive_at_)
		end

		def alive_record(opt={})
			find_by(opt.merge({deleted: _alive_at_}))
		end

		def alive_record_or_initialize_by(opt={})
			find_or_initialize_by(opt.merge({deleted: _alive_at_}))
		end

		def alive_records
			where(deleted: _alive_at_)
		end

		def find_email(email)
			return nil if email.blank?
			return find_by(email: email, deleted: _alive_at_)
		end

		def hash_password(password, salt, magic=auth_magic)
			OpenSSL::HMAC.hexdigest('sha256', salt, "#{password}:#{magic}")
		end
		def create_password
			#return  SecureRandom.hex(4).downcase
			o = [('a'..'z'), ('0'..'9')].map { |i| i.to_a }.flatten
			return (0...8).map { o[rand(o.length)] }.join.downcase
		end
		def new_salt
			("a".."z").to_a.sample(10).join
		end

		def auth_magic; 'E6DcPVwMvqhBdsFqDGCpdsiJEYPVFBTdaw9YU' end

		def mkdir_p_(dir_path)
			FileUtils.mkdir_p(dir_path) unless FileTest.exist?(dir_path)
			return dir_path
		end

		def sex_female()    {name: "女性",id: 0} ;end
		def sex_male()  {name: "男性",id: 1} ;end
		def sex_unknown() {name: "不明",id: 2} ;end
		def sex_choices
			[[sex_female[:name],sex_female[:id]],[sex_male[:name],sex_male[:id]],[sex_unknown[:name],sex_unknown[:id]]]
		end

		def date_with_wdays(tmp_date)
			wdays = select_wdays
			"#{tmp_date.strftime("%Y年%m月%d日")}（#{wdays[tmp_date.wday]}曜日）"
		end
		def no_yyyyy_date_with_wdays(tmp_date)
			wdays = select_wdays
			"#{tmp_date.strftime("%m月%d日")}(#{wdays[tmp_date.wday]})"
		end

		def address_sym
			[
					:first_name,
					:family_name,
					:first_name_kana,
					:family_name_kana,
					:zip,
					:zip1,
					:zip2,
					:pref,
					:city,
					:address1,
					:building,
					:company_option1,
					:company_option2,
					:tel,
					:tel1,
					:tel2,
					:tel3,
			]
		end
		def human_html(human_)
			case human_
				when "◯" ; "#{human_}"
				when "×" ; "#{human_}"
				else human_
			end
		end

		def set_id_sequential(value=nil, set_next=false)
			if value.nil?
				if maximum(:id).to_i.zero?
					value, set_next = 1, false
				else
					value, set_next = maximum(:id), true
				end
			end
			seq_name = "'#{table_name}_id_seq'"

			arguments = [seq_name, value, set_next].join(",")
			"nextval: #{set_next ? value+1 : value}"
			puts sql = "select setval(#{arguments})"
			connection.execute(sql)
		end
		def select_yyyymm(yyyymm=nil,s_cnt=1,e_cnt=6,sym="")
			values1 = []
			values2 = []
			today   = Date.today#.strftime("%Y%m")
			yyyymm  = nil if yyyymm.to_s.length != 6

			s_cnt.times do |i|
				values2 << [(today >> i+1).strftime("%Y年%m月#{sym}"),(today >> i+1).strftime("%Y%m").to_i]
			end
			e_cnt.times do |i|
				values1 << [(today << i+1).strftime("%Y年%m月#{sym}"),(today << i+1).strftime("%Y%m").to_i]
			end

			yyyymm_arr = values1.reverse + [[today.strftime("%Y年%m月#{sym}"),today.strftime("%Y%m").to_i]] + values2
			yyyymm_arr =[["#{ show_yyyymm(yyyymm)}#{sym}",yyyymm.to_i]] + yyyymm_arr  if yyyymm && !yyyymm_arr.flatten.include?(yyyymm.to_i)
			return yyyymm_arr

		end

		def invalid_title() "【緊急用対応エラー】";end



	end

end
