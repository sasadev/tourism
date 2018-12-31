class Admin::ContentsController < Admin::BaseController
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :destroy

  def index
    query = params
    search_remained(query)
    @contents, @query = ContentSearchForm.generate_objects(admin_query_params, admin_user: @current_admin_user)
  end

  def search
  end

  def show
  end

  def new
    @content = Content.new
    @content.content_images.build
  end

  def create
    @content = Content.new(content_params)

    if @content.save
      redirect_to edit_admin_content_path(@content), notice: t('activerecord.flash.content.actions.destroy.success')
    else
      flash.now[:alert] = t('activerecord.flash.content.actions.create.failure')
      render :new
    end
  end

  def edit
     @category = @content.category
  end

  def update
    if @content.update(content_params)
      redirect_to edit_admin_content_path(@content), notice: t('activerecord.flash.content.actions.update.success')
    else
      render :edit
    end
  end

  def destroy
    if @content.soft_delete
      redirect_to admin_contents_path, notice: t('activerecord.flash.content.actions.destroy.success')
    else
      flash[:alert] = t('activerecord.flash.content.actions.destroy.failure')
      redirect_to admin_contents_path
    end
  end

  def zip_search
    address_opt = content_params[:zip].to_i
    zip_list = ZipList.zip_find({zip: address_opt})


    render_javascript_response do |page|
      if zip_list
        prefecture_id = Prefecture.select(:id, :name).find_by(name: zip_list.pref).try(:id)
        page.code << "$(\"#content_prefecture_id\").val(\"#{prefecture_id.to_s}\");"
        page.code << "$(\"#content_address\").val(\"#{zip_list.city}#{zip_list.town}\");"
        page.code << "$(\"#content_address\").focus();"
      else
        page.alert '郵便番号が見つかりませんでした'
      end
    end
  rescue => e
    p e
  end

  def mod_category
    @content = Content.find_or_initialize_by(id: params[:id])
    @content.attributes = content_params

    @category = Category.find_by(id: content_params[:category_id])

    render partial: "form"
  end

  private
  def set_content
    @content = Content.find_by(id: params[:id])
  end

  def content_params
    params.require(:content).permit!
  end
end