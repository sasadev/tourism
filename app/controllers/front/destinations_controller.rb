class Front::DestinationsController < Front::BaseController
  before_action :set_destination, only: [:edit, :update, :destroy]
  before_action :authenticate!, except: [:new, :create, :start_zip_search , :end_zip_search]

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      session[:destination_id] = @destination.to_param
      redirect_to edit_destination_path(@destination), notice: t('activerecord.flash.destination.actions.create.success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    @destination.attributes = destination_params

    if @destination.save
      redirect_to edit_destination_path(@destination), notice: t('activerecord.flash.destination.actions.update.success')
    else
      render :edit, notice: t('activerecord.flash.destination.actions.update.failure')
    end
  end

  def start_zip_search
    address_opt = destination_params[:start_zip].to_i
    zip_list = ZipList.zip_find({zip: address_opt})


    render_javascript_response do |page|
      if zip_list
        prefecture_id = Prefecture.select(:id, :name).find_by(name: zip_list.pref).try(:id)
        page.code << "$(\"#destination_start_prefecture_id\").val(\"#{prefecture_id.to_s}\");"
        page.code << "$(\"#destination_start_address\").val(\"#{zip_list.city}#{zip_list.town}\");"
        page.code << "$(\"#destination_start_address\").focus();"
      else
        page.alert '郵便番号が見つかりませんでした'
      end
    end
  rescue => e
    p e
  end

  def end_zip_search
    address_opt = destination_params[:end_zip].to_i
    zip_list = ZipList.zip_find({zip: address_opt})


    render_javascript_response do |page|
      if zip_list
        prefecture_id = Prefecture.select(:id, :name).find_by(name: zip_list.pref).try(:id)
        page.code << "$(\"#destination_end_prefecture_id\").val(\"#{prefecture_id.to_s}\");"
        page.code << "$(\"#destination_end_address\").val(\"#{zip_list.city}#{zip_list.town}\");"
        page.code << "$(\"#destination_end_address\").focus();"
      else
        page.alert '郵便番号が見つかりませんでした'
      end
    end
  rescue => e
    p e
  end

  def selects

  end

  private
  def set_destination
    @destination = Destination.custom_find_by(id: params[:id])
  end
  def destination_params
    params.require(:destination).permit!
  end
end