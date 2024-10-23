class BookingsController < ApplicationController
  before_action :set_arena, only: [:new, :create]

  def new
    @bookings = Booking.where(arena_id: @arena.id)
    @booking = @arena.bookings.new
    if current_user.nil?
      flash[:alert] = "Vous devez être connecté pour réserver une salle."
      redirect_to new_user_session_path and return
    end
    if current_user.category != 'band'
      flash[:alert] = "Vous devez être un artiste pour réserver une salle."
      redirect_to root_path and return
    end
  end

  def create
    @now = Time.current
    @booking = @arena.bookings.new(booking_params)
    @booking.user_id = current_user.id
    @booking.end = combine_date_time_params_end
    @booking.start = combine_date_time_params_start
    @days = (@booking.end - @booking.start).to_i
    if @days == 0
      redirect_to arena_path(@arena), alert: "La réservation doit être d'au moins une journée."
      return
    end
    @booking.total = @days * @arena.price
    if @booking.start < @now || @booking.end < @now
      redirect_to arena_path(@arena), alert: "Vous ne pouvez pas réserver un créneau dans le passé ou le jour même."
      return
    end
    if @booking.start > @booking.end
      redirect_to arena_path(@arena), alert: "La date de fin doit être postérieure à la date de début."
      return
    end
    if booking_exist?
      redirect_to arena_path(@arena), alert: "Ce créneau est déjà réservé."
      return
    end
    if redirect_to arena_path(@arena), notice: "Réservation effectuée avec succès."
      @booking.save
    else render :new
    end
  end

  def mine
    @bookings = Booking.where(user_id: current_user.id)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to booking_mine_path, notice: 'La réservation a été supprimée avec succès.'
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
