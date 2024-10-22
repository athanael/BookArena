class BookingsController < ApplicationController
  before_action :set_arena, only: [:new, :create]

  def new
    @booking = @arena.bookings.new
  end

  def create
    @booking = @arena.bookings.new(booking_params)
    @booking.user_id = current_user.id
    @booking.end = combine_date_time_params_end
    @booking.start = combine_date_time_params_start
    if booking_exist?
      redirect_to arena_path(@arena), alert: "Ce créneau est déjà réservé."
      return
    end
    if redirect_to arena_path(@arena), notice: "Réservation effectuée avec succès."
    else render :new
    end
  end

  private

  def booking_exist?
    @arena.bookings.where('"start" < ? AND "end" > ?', @booking.end, @booking.start).exists?
  end

  def set_arena
    @arena = Arena.find(params[:arena_id])
  end

  def combine_date_time_params_end
    combine_datetime(params[:booking], :end)
  end

  def combine_date_time_params_start
    combine_datetime(params[:booking], :start)
  end

  def combine_datetime(hash, key)
    DateTime.new(
      hash["#{key}(1i)"].to_i,
      hash["#{key}(2i)"].to_i,
      hash["#{key}(3i)"].to_i,
      hash["#{key}(4i)"].to_i,
      hash["#{key}(5i)"].to_i
    )
  end

  def booking_params
    params.require(:booking).permit(:start, :end, :total, :status, :user_id, :arena_id)
  end
end
