class Admin::SystemConfigsController < Admin::BaseController
  before_action :set_system_config, only: [:update]

  def index
    @system_config = SystemConfig.find_or_create_by(available: 1)
  end

  def import_zip_list
    Thread.start do
      errors = ZipList.import_from_csv(params[:zip_source]) if params[:zip_source].present?
    if errors.blank?
      flash[:notice] = "更新が完了しました"
      redirect_to  admin_system_configs_path
    else
      flash.now[:alert] = "更新に失敗しました"
      render :index
    end
    end
  end

  private

  def set_system_config
    @system_config = SystemConfig.find_by(id: params[:id])
  end

  def admin_system_config_params
    params.require(:system_config).permit!
  end
end
