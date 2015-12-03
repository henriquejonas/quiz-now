class ProfilesController < LoginRequiredController

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update_attributes(profile_params)
      redirect_to root_path, notice: t('messages.controllers.profiles.profile_successfully_updated')
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name)
  end
end
