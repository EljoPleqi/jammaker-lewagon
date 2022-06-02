class Recipe < ApplicationRecord
  require "open-uri"
  belongs_to :user
  has_many :instructions

  def self.scraper(recipe)
    # 1. We get the HTML page content
    @recipe = recipe
    html_content = URI.open(@recipe.url).read
    # 2. We build a Nokogiri document from this file
    doc = Nokogiri::HTML(html_content)
    @elements = doc.search('.recipe-meta-item-body')
    @preptime = @elements[2].text.strip
    # hour = @preptime.match(/(\d+) hr/)[1].to_i * 60
    # min = @preptime.match(/(\d+) min/)[1].to_si
    @url = @recipe.url
    # @preptime = 60 + 30
    @elements2 = doc.search('.headline')
    @title = @elements2.text.strip
    @elements3 = doc.search('.ingredients-section')
    @ingredients = @elements3.text.strip
    @elements4 = doc.search('.recipe-instructions')
    @steps = @elements4.text.strip
    @elements5 = doc.search('.lead-media img')
    @image = @elements5.attribute("src").value
    @recipe.title = @title
    @recipe.preptime = @preptime
    @recipe.ingredients = @ingredients
    @recipe.steps = @steps
    @recipe.url = @image
    return @recipe
  end
end
