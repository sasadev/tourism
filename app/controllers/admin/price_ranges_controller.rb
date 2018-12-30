class Admin::PriceRangesController < Admin::BaseController
  before_action :set_price_range, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :destroy

  def index
    query = params
    search_remained(query)
    @price_ranges, @query = PriceRangeSearchForm.generate_objects(admin_query_params, admin_user: @current_admin_user)
  end

  def search
  end

  def show
  end

  def new
    @price_range = PriceRange.new
  end

  def create
    @price_range = PriceRange.new(price_range_params)
    sort = PriceRange.last.try(:sort_seq)
    if sort.present?
      @price_range.sort_seq = (sort.to_i + 1)
    else
      @price_range.sort_seq = 1
    end
    if @price_range.save
      redirect_to edit_admin_price_range_path(@price_range), notice: t('activerecord.flash.price_range.actions.create.success')
    else
      flash.now[:alert] = t('activerecord.flash.price_range.actions.create.failure')
      render :new
    end
  end

  def edit
  end

  def update
    if @price_range.update(price_range_params)
      redirect_to edit_admin_price_range_path(@price_range), notice: t('activerecord.flash.price_range.actions.update.success')
    else
      flash.now[:alert] = t('activerecord.flash.price_range.actions.update.failure')
      render :edit
    end
  end

  def destroy
    if @price_range.soft_delete
      redirect_to admin_price_ranges_path, notice: t('activerecord.flash.price_range.actions.destroy.success')
    else
      flash[:alert] = t('activerecord.flash.price_range.actions.destroy.failure')
      redirect_to admin_price_ranges_path
    end
  end

  def sort
    if request.post?
      begin
        PriceRange.transaction do
          params[:price_range_contents].each.with_index(1) do |price_range_id,i|
            price_range = PriceRange.find_by(id: price_range_id)
            price_range.sort_seq = i
            price_range.save
          end
        end
        flash[:notice] = t('activerecord.flash.price_range.actions.sort_seq.success')
      rescue => e
        p e
        flash[:alert] = t('activerecord.flash.price_range.actions.sort_seq.failure')
      end
    end

    redirect_to action: :index
  end

  private
  def set_price_range
    @price_range = PriceRange.find_by(id: params[:id])
  end

  def price_range_params
    params.require(:price_range).permit!
  end
end