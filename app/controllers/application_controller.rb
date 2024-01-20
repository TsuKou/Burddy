class ApplicationController < ActionController::Base
  # before_action :authenticate_admin!, if: :admin_url

  # def admin_url
  #     request.fullpath.include?("/admin")
  # end
  


  #　URL(path)に「\admin」が含まれているページは「admin」ログインしていないと閲覧できない

  # before_action :configure_permitted_parameters, if: :devise_controller?

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
  #   # 新規登録時(sign_up時)にuser_nameというキーのパラメーターを追加で許可する
  # end


end
