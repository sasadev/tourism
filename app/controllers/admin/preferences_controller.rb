class Admin::PreferencesController < Admin::BaseController
  before_action :set_preference, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :destroy

  def index
    query = params
    search_remained(query)
    @preferences, @query = PreferenceSearchForm.generate_objects(admin_query_params, admin_user: @current_admin_user)
  end

  def search
  end

  def show
  end

  def new
    @preference = Preference.new
  end

  def create
    @preference = Preference.new(preference_params)
    sort = Preference.last.try(:sort_seq)
    if sort.present?
      @preference.sort_seq = (sort.to_i + 1)
    else
      @preference.sort_seq = 1
    end
    if @preference.save
      redirect_to edit_admin_preference_path(@preference), notice: t('activerecord.flash.preference.actions.create.success')
    else
      flash.now[:alert] = t('activerecord.flash.preference.actions.create.failure')
      render :new
    end
  end

  def edit
  end

  def update
    if @preference.update(preference_params)
      redirect_to edit_admin_preference_path(@preference), notice: t('activerecord.flash.preference.actions.update.success')
    else
      flash.now[:alert] = t('activerecord.flash.preference.actions.update.failure')
      render :edit
    end
  end

  def destroy
    if @preference.soft_delete
      redirect_to admin_preferences_path, notice: t('activerecord.flash.preference.actions.destroy.success')
    else
      flash[:alert] = t('activerecord.flash.preference.actions.destroy.failure')
      redirect_to admin_preferences_path
    end
  end

  def sort
    if request.post?
      begin
        Preference.transaction do
          params[:preference_contents].each.with_index(1) do |preference_id,i|
            preference = Preference.find_by(id: preference_id)
            preference.sort_seq = i

            preference.save
          end
        end
        flash[:notice] = t('activerecord.flash.preference.actions.sort_seq.success')
      rescue => e
        p e
        flash[:alert] = t('activerecord.flash.preference.actions.sort_seq.failure')
      end
    end

    redirect_to action: :index
  end

  private
  def set_preference
    @preference = Preference.find_by(id: params[:id])
  end

  def preference_params
    params.require(:preference).permit!
  end
end