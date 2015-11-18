class LoginRequiredController < ApplicationController
  before_filter :authorize

  private

  def authorize
    unless logged_in?
      session[:return_to] = request.url # guarda a URL para um redirecionamento após o login
      redirect_to new_session_path, alert: t('messages.login_required')
    end
  end
end
