class ArenasController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @arenas = Arena.all
  end

  def show
    @arena = Arena.find(params[:id])
  end

  def new
    @arena = Arena.new
  end

  def create
    if current_user.nil?
      flash[:alert] = "Vous devez être connecté pour créer une arène."
      redirect_to new_user_session_path and return
    end

    if current_user.category != 'owner'
      flash[:alert] = "Vous devez être un propriétaire pour créer une arène."
      redirect_to root_path and return
    end
    @arena = Arena.new(arena_params)
    @arena.user = current_user

    if @arena.save
      redirect_to arena_path(@arena), notice: 'La salle a été créée avec succès.'
    else
      logger.error "Erreur lors de la création de l'arène : #{@arena.errors.full_messages.join(', ')}"
      render :new
    end
  end


  private

  def arena_params
    params.require(:arena).permit(:name, :capacity, :address, :price, :description, :photo)
  end
end
