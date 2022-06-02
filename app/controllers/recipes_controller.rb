class RecipesController < ApplicationController
  #remove skip
  skip_before_action :authenticate_user!
  require "open-uri"

  def index
    @recipes = Recipe.all
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipes_params)
    @recipe = Recipe.scraper(@recipe)
    #change Usser.last to current_user
    @recipe.user = User.last
    @recipe.save
    @instructions = Instruction.parse(@recipe.steps)
    @instructions.each do |instruction|
      Instruction.create(content: instruction, recipe: @recipe)
    end
    redirect_to recipe_path(@recipe)
  end

  def show
    #find recipes to show
    #show all of the instructions for that recipes
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions
  end

  def destroy
    @recipes.destroy
    redirect_to recipes_path
  end

  private
  def recipes_params
    params.require(:recipe).permit(:url)
  end
end
