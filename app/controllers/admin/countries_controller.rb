class Admin::CountriesController < Admin::BaseController
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :destroy

  def index
    query = params
    search_remained(query)
    @countries, @query = CountrySearchForm.generate_objects(admin_query_params, admin_user: @current_admin_user)
  end

  def search
  end

  def show
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    sort = Country.last.try(:sort_seq)
    if sort.present?
      @country.sort_seq = (sort.to_i + 1)
    else
      @country.sort_seq = 1
    end
    if @country.save
      redirect_to edit_admin_country_path(@country), notice: t('activerecord.flash.country.actions.create.success')
    else
      flash.now[:alert] = t('activerecord.flash.country.actions.create.failure')
      render :new
    end
  end

  def edit
  end

  def update
    if @country.update(country_params)
      redirect_to edit_admin_country_path(@country), notice: t('activerecord.flash.country.actions.update.success')
    else
      flash.now[:alert] = t('activerecord.flash.country.actions.update.failure')
      render :edit
    end
  end

  def destroy
    if @country.soft_delete
      redirect_to admin_countries_path, notice: t('activerecord.flash.country.actions.destroy.success')
    else
      flash[:alert] = t('activerecord.flash.country.actions.destroy.failure')
      redirect_to admin_countries_path
    end
  end

  def sort
    if request.post?
      begin
        Country.transaction do
          params[:country_contents].each.with_index(1) do |country_id,i|
            country = Country.find_by(id: country_id)
            country.sort_seq = i

            country.save
          end
        end
        flash[:notice] = t('activerecord.flash.country.actions.sort_seq.success')
      rescue => e
        p e
        flash[:alert] = t('activerecord.flash.country.actions.sort_seq.failure')
      end
    end

    redirect_to action: :index
  end

  private
  def set_country
    @country = Country.find_by(id: params[:id])
  end

  def country_params
    params.require(:country).permit!
  end
end