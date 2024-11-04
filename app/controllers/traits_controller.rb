class TraitsController < ApplicationController 
  def index
    @traits = Trait.all
  end
  
  def new
    @trait = Trait.new
  end

  def create
    @trait = Trait.new(trait_params)

    if @trait.save
      redirect_to traits_path, notice: 'Característica salva com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível cadastrar a característica'
      render :new, status: :unprocessable_entity 
    end
  end

  private 
  def trait_params
    params.require(:trait).permit(:name)
  end
end