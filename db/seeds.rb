# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
<<<<<<< HEAD
require 'nokogiri'
require 'open-uri'

Recipe.destroy_all
#User.destroy_all

User.create(email: "s@gmail.com", password: "secret")

def scraper(url)
  @recipe = Recipe.new(url: url, user: User.last)
  # 1. We get the HTML page content
  html_content = URI.open(url).read
  # 2. We build a Nokogiri document from this file
  doc = Nokogiri::HTML(html_content)
  @elements = doc.search('.recipe-meta-item-body')
  @preptime = @elements[2].text.strip
  hour = @preptime.match(/(\d+) hr/)[1].to_i * 60
  min = @preptime.match(/(\d+) min/)[1].to_i
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
  @recipe.save
end

scraper("https://www.allrecipes.com/recipe/267291/chicken-taco-lasagna/")
puts "Created #{Recipe.last.title}"
=======
>>>>>>> refs/remotes/origin/main
