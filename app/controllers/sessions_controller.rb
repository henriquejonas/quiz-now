class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.uid.nil? && user.authenticate(params[:password])
      successful_login(user)
      redirect_to_target_or_default root_url, notice: t('messages.controllers.sessions.login_successfully')
    else
      flash.now.alert = t('messages.controllers.sessions.invalid_email_or_password')
      render 'new'
    end
  end

  def destroy
    current_user.update_attribute :status, :offline unless current_user.nil?
    cookies.delete :user_id, domain: :all
    redirect_to root_path, notice: t('messages.controllers.sessions.logout_successfully')
  end

  def create_omniauth
    user = User.find_by(email: request.env['omniauth.auth']['info']['email'])
    if user && user.provider == request.env['omniauth.auth']['provider']
      successful_login(user)
      redirect_to_target_or_default root_url, notice: t('messages.controllers.sessions.login_successfully')
    elsif user.nil?
      user = User.new
      user.create_omniauth(request.env['omniauth.auth'])
      if user.save
        successful_login(user)
        redirect_to_target_or_default root_url, notice: t('messages.controllers.sessions.login_successfully')
      else
        redirect_to root_path, alert: t('messages.controllers.sessions.error_on_login')
      end
    else
      redirect_to login_path(email: request.env['omniauth.auth']['info']['email']), alert: t('messages.controllers.sessions.user_exists')
    end
  end

  def rejected_omniauth
    redirect_to home_index_path, alert: t('messages.controllers.sessions.error_on_login')
  end

  private

  def successful_login(user)
    if params[:remember_me] # mantém o usuário conectado por 2 semanas
      cookies.signed[:user_id] = {value: user.id, expires: 2.weeks.from_now, domain: :all}
    else # o usuário será desconectado quando fechar o navegador
      cookies.signed[:user_id] = {value: user.id, domain: :all}
    end
    user.status         = :online
    user.last_access_ip = request.remote_ip
    user.last_access_at = Time.now
    user.save(validate: false)
  end

  def redirect_to_target_or_default(default, *args)
    # redireciona para uma URL que possa ter sido armazenada por LoginRequiredController ou para default
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end
end
