class ArenasController < ApplicationController
  def index
    @arenas = Arena.all
  end

  def show
    @arena = Arena.find(params[:id])
  end
end
