class Admin::TransportationsController < Admin::BaseController
  before_action :set_transportation, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :destroy

  def index
    query = params
    search_remained(query)
    @transportations, @query = TransportationSearchForm.generate_objects(admin_query_params, admin_user: @current_admin_user)
  end

  def search
  end

  def show
  end

  def new
    @transportation = Transportation.new
  end

  def create
    @transportation = Transportation.new(transportation_params)
    sort = Transportation.last.try(:sort_seq)
    if sort.present?
      @transportation.sort_seq = (sort.to_i + 1)
    else
      @transportation.sort_seq = 1
    end
    if @transportation.save
      redirect_to edit_admin_transportation_path(@transportation), notice: t('activerecord.flash.transportation.actions.create.success')
    else
      flash.now[:alert] = t('activerecord.flash.transportation.actions.create.failure')
      render :new
    end
  end

  def edit
  end

  def update
    if @transportation.update(transportation_params)
      redirect_to edit_admin_transportation_path(@transportation), notice: t('activerecord.flash.transportation.actions.update.success')
    else
      flash.now[:alert] = t('activerecord.flash.transportation.actions.update.failure')
      render :edit
    end
  end

  def destroy
    if @transportation.soft_delete
      redirect_to admin_transportations_path, notice: t('activerecord.flash.transportation.actions.destroy.success')
    else
      flash[:alert] = t('activerecord.flash.transportation.actions.destroy.failure')
      redirect_to admin_transportations_path
    end
  end

  def sort
    if request.post?
      begin
        Transportation.transaction do
          params[:transportation_contents].each.with_index(1) do |transportation_id,i|
            transportation = Transportation.find_by(id: transportation_id)
            transportation.sort_seq = i

            transportation.save
          end
        end
        flash[:notice] = t('activerecord.flash.transportation.actions.sort_seq.success')
      rescue => e
        p e
        flash[:alert] = t('activerecord.flash.transportation.actions.sort_seq.failure')
      end
    end

    redirect_to action: :index
  end

  private
  def set_transportation
    @transportation = Transportation.find_by(id: params[:id])
  end

  def transportation_params
    params.require(:transportation).permit!
  end
end