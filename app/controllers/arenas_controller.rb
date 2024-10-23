class ArenasController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @arenas = Arena.all
    if current_user.category
      redirect_to arenas_mine_path and return
    end
  end

  def show
    @arena = set_arena
    @bookings = Booking.where(arena_id: @arena.id)
  end

  def new
    @arena = Arena.new
  end

  def create
    if current_user.nil?
      flash[:alert] = "Vous devez être connecté pour créer une salle."
      redirect_to new_user_session_path and return
    end

    if current_user.category != 'owner'
      flash[:alert] = "Vous devez être un propriétaire pour créer une salle."
      redirect_to root_path and return
    end
    @arena = Arena.new(arena_params)
    @arena.user = current_user

    if @arena.save
      redirect_to arena_path(@arena), notice: 'La salle a été créée avec succès.'
    else
      logger.error "Erreur lors de la création de la salle : #{@arena.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def destroy
    @arena = set_arena
    @arena.destroy

    redirect_to arenas_path, notice: 'La salle a été supprimée avec succès.'
  end

  def mine
    @arenas = current_user.arenas
  end

  private

  def set_arena
    @arena = Arena.find(params[:id])
  end

  def arena_params
    params.require(:arena).permit(:name, :capacity, :address, :price, :description, :photo)
  end
end
