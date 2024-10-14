class CancellationMailer < ApplicationMailer
  def cancellation_notification
    @artist = params[:artist]
    @arena = params[:arena]

    mail(
      to: @arena.user.email,
      subject: "Annulation de votre prestation à #{@arena.name}"
    )
  end
end
