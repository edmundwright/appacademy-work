class CatsController < ApplicationController
  def index
    @cats = Cat.all
    #render :index not necessary as method X automatically renders view X
  end

  def show
    @cat = Cat.find(params[:id])
    #render :show
  end

  def new
    @cat = Cat.new
    #render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    #render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to @cat # can use instead of cat_url(@cat)
    else
      render :edit
    end
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to @cat
    else
      render :new
    end
  end

  def cat_params
    params.require(:cat).permit(:name,:color,:sex,:description,:birth_date)
  end
end
