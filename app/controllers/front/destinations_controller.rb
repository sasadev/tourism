class Front::DestinationsController < Front::BaseController
  before_action :set_destination, only: [:edit, :update, :destroy]
  before_action :authenticate!, except: [:new, :create, :start_zip_search , :end_zip_search]
  before_action :find_destination_content, only: [:add_like, :no_like]

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

  def add_content
    destination_content = @destination.destination_contents.new(content_id: params[:content_id])
    if destination_content.save
      flash[:notice] = 'お気に入りに追加しました'
      redirect_to selects_destinations_path
    else
      flash[:alert] = 'お気に入り登録に失敗しました'
      redirect_to tour_select_path(id: params[:id])
    end
  end

  def add_like
    @destination_content.like = 1

    select_destination_content_sort = @destination.destination_contents.where(like: 1).pluck(:sort_seq)

    if select_destination_content_sort.present?
      max_number = select_destination_content_sort.max
      @destination_content.sort_seq = max_number + 1
    else
      @destination_content.sort_seq = 1
    end

    if @destination_content.save
      flash[:notice] = '追加しました'
      redirect_to selects_destinations_path
    else
      flash[:alert] = '追加に失敗しました'
      redirect_to selects_destinations_path
    end
  end

  def no_like
    @destination_content.like = 0
    if @destination_content.save
      flash[:notice] = '戻しました'
      redirect_to selects_destinations_path
    else
      flash[:alert] = '失敗しました'
      redirect_to selects_destinations_path
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
    contents = @destination.contents.eager_load(:destination_contents)
    @favorite_contents = contents.where(destination_contents: {like: 0})
    @like_contents     = contents.where(destination_contents: {like: 1}).order('destination_contents.sort_seq asc')
  end

  def find_destination_content
    @destination_content = @destination.destination_contents.find_by(content_id: params[:content_id])
  end

  def complete
    @destination.total_distance = params[:total_distance].to_f if params[:total_distance].present?
    @destination.total_time = params[:total_time].to_i if params[:total_time].present?
    @destination.total_amount = params[:total_amount].to_i if params[:total_amount].present?
    @destination.save

    session[:destination_id] = nil
    redirect_to root_path
  end

  private
  def set_destination
    @destination = Destination.custom_find_by(id: params[:id])
  end
  def destination_params
    params.require(:destination).permit!
  end
end