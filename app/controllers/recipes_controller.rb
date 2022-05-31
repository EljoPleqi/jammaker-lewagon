class RecipesController < ApplicationController
  require "open-uri"

  def index
    @recipes = Recipe.all
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipes_params)
    scraper(@recipe.url)
    @recipe.user = current_user
    @recipe.save
    redirect_to recipes_path
  end

  def show
  end

  def destroy
  end

  private

  def scraper(url)
    # 1. We get the HTML page content
    html_content = URI.open(url).read
    # 2. We build a Nokogiri document from this file
    doc = Nokogiri::HTML(html_content)
    @elements = doc.search('.recipe-meta-item-body')
    @preptime = @elements[2].text.strip
    hour = @preptime.match(/(\d+) hr/).to_i * 60
    min = @preptime.match(/(\d+) min/).to_i
    @preptime = hour + min
    @elements2 = doc.search('.headline')
    @title = @elements2.text.strip
    @elements3 = doc.search('.ingredients-section')
    @ingredients = @elements3.text.strip
    @elements4 = doc.search('.recipe-instructions')
    @instructions = @elements4.text.strip
    @recipe.title = @title
    @recipe.preptime = @preptime
    @recipe.ingredients = @ingredients
    @recipe.instructions = @instructions
  end

  def recipes_params
    params.require(:recipe).permit(:url)
  end
end
