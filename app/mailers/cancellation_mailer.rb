class CancellationMailer < ApplicationMailer
  def cancellation_notification
    @artist = params[:artist]
    @arena = params[:arena]

    if @arena && @arena.user && @arena.user.email
      mail(
        to: @arena.user.email,
        subject: "Annulation de votre prestation à #{@arena.name}"
      )
    else
      Rails.logger.error("CancellationMailer: Missing arena or user email")
    end
  end
end
