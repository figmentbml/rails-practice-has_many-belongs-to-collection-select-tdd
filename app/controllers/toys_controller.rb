class ToysController < ApplicationController

  def index
    @toys = Toy.all
  end

  def show
    @toy = Toy.find(params[:id])
  end

  def new
    @toy = Toy.new
  end

  def create
    @toy = Toy.new(params.require(:toy).permit(:name, :cat_id))
    @toy.save
    redirect_to toys_path
  end

  def edit
    @toy = Toy.find(params[:id])
  end

  def update
    Toy.find(params[:id]).update(params.require(:toy).permit(:name, :cat_id))
    redirect_to toys_path
  end

end
