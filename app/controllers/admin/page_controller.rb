class Admin::PageController < Admin::BaseController
  layout false
  before_action :authenticate!, except: [ :login, :no_access_right ]
  skip_before_action :set_breadcrumbs

  protect_from_forgery :except => [:login]

  def index
    render layout: 'admin'
  end

  def no_access_right
    render layout: 'admin'
  end

  def login
    return render if request.get?
    if @admin_user = AdminUser.authenticate(admin_admin_user_params)
      session[:admin_user_id]  = @admin_user.id

      return redirect_to admin_root_path, notice: t('messages.signed_in')
    else
      flash[:alert] = t('messages.signed_in_failed')
    end
  end

  def no_access_rights
    render text: 'アクセス権限がありません'
  end

  def logout
    session[:admin_user_id] = nil
    redirect_to admin_login_path
  end

  private

  def admin_admin_user_params
    params.require(:admin_user).permit(:email, :password)
  end
end
