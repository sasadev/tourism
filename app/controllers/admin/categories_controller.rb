class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :destroy

  def index
    query = params
    search_remained(query)
    @categories, @query = CategorySearchForm.generate_objects(admin_query_params, admin_user: @current_admin_user)
  end

  def search
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    sort = Category.last.try(:sort_seq)
    if sort.present?
      @category.sort_seq = (sort.to_i + 1)
    else
      @category.sort_seq = 1
    end
    if @category.save
      redirect_to edit_admin_category_path(@category), notice: t('activerecord.flash.category.actions.create.success')
    else
      flash.now[:alert] = t('activerecord.flash.category.actions.create.failure')
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to edit_admin_category_path(@category), notice: t('activerecord.flash.category.actions.update.success')
    else
      flash.now[:alert] = t('activerecord.flash.category.actions.update.failure')
      render :edit
    end
  end

  def destroy
    if @category.soft_delete
      redirect_to admin_categories_path, notice: t('activerecord.flash.category.actions.destroy.success')
    else
      flash[:alert] = t('activerecord.flash.category.actions.destroy.failure')
      redirect_to admin_categories_path
    end
  end

  def sort
    if request.post?
      begin
        Category.transaction do
          params[:category_contents].each.with_index(1) do |category_id,i|
            category = Category.find_by(id: category_id)
            category.sort_seq = i

            category.save
          end
        end
        flash[:notice] = t('activerecord.flash.category.actions.sort_seq.success')
      rescue => e
        p e
        flash[:alert] = t('activerecord.flash.category.actions.sort_seq.failure')
      end
    end

    redirect_to action: :index
  end

  private
  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit!
  end
end