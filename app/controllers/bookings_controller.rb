class BookingsController < ApplicationController
  def index
    arena = Arena.find(params[:arena_id])
    @bookings = arena.bookings

    render json: @bookings.map { |booking|
      {
        title: booking.user.name,
        start: booking.start,
        end: booking.end
      }
    }
  end

  def new
    @arena = Arena.find(params[:arena_id])
    @booking = @arena.bookings.new
  end

  def create
    @arena = Arena.find(params[:arena_id])
    @booking = @arena.bookings.new(booking_params)
    @booking.user = current_user # Associe l'utilisateur actuel

    if @booking.save
      redirect_to arena_path(@arena), notice: 'Réservation créée avec succès.'
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start, :end)
  end
end
