class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    # Trouver l'utilisateur courant
    @user = User.find(current_user.id)

    # Supprimer l'utilisateur et gérer les dépendances
    if @user.destroy
      # Déconnecter l'utilisateur après la suppression
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      set_flash_message! :notice, :destroyed
      yield resource if block_given?

      # Rediriger vers la page d'accueil ou une autre page
      redirect_to root_path, notice: "Votre compte a bien été supprimé."
    else
      # Gérer les erreurs de suppression
      redirect_to edit_user_registration_path, alert: "Une erreur est survenue, votre compte n'a pas pu être supprimé : #{@user.errors.full_messages.join(', ')}"
    end
  end
end
