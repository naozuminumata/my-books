class ApplicationController < ActionController::Base
  # before_action :set_current_user

  # def set_current_user
  #     @current_user = User.find_by(id: session[:user_id])
  # end

  # def authenticate_user
  #   if @current_user == nil
  #     flash[:notice] = "ログインが必要です"
  #     redirect_to("/login")
  #   end
  # end

  # def forbid_login_user
  #   if @current_user != nil
  #     flash[:notice] = "すでにログインしています"
  #     redirect_to("/posts/index")
  #   end
  # end

  protect_from_forgery with: :exception

  # deviseコントローラーにストロングパラメータを追加する          
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :days, :boxes])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :word])
  end
  
end
