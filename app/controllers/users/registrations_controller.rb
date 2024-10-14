class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    self.resource = resource_class.new
    # Optionally, set default values for fields
    resource.first_name = ''
    resource.last_name = ''
    resource.category = ''

    # If you're using any instance variables in the view (like @minimum_password_length), set them here
    @minimum_password_length = resource_class.password_length.min
    super
  end

  # DELETE /resource
  def destroy
    # Find the current user
    @user = User.find(current_user.id)

    # Delete the user and handle dependencies
    if @user.destroy
      # Sign out the user after deletion
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      set_flash_message! :notice, :destroyed
      yield resource if block_given?

      # Redirect to the home page or another page
      redirect_to root_path, notice: "Votre compte a bien été supprimé."
    else
      # Handle deletion errors
      redirect_to edit_user_registration_path, alert: "Une erreur est survenue, votre compte n'a pas pu être supprimé : #{@user.errors.full_messages.join(', ')}"
    end
  end

  private

  # Permit additional parameters for sign-up
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :category, :email, :password, :password_confirmation)
  end
end
