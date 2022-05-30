class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def scraper
    filepath = "/home/same/code/samemah24/jammaker/chicken.html"
    # 1. We get the HTML page content
    html_content = File.open(filepath)
    # 2. We build a Nokogiri document from this file
    doc = Nokogiri::HTML(html_content)
    @elements = doc.search('.recipe-meta-item-body')
    @preptime = @elements[2].text.strip
    @elements2 = doc.search('.headline')
    @title = @elements2.text.strip
    @elements3 = doc.search('.ingredients-item-name')
    @ingredients = @elements3.text.strip
    @elements4 = doc.search('.paragraph p')
    @instructions = @elements4.text.strip
    @recipe = {
      title: @title,
      preptime: @preptime,
      ingredients: @ingredients,
      instructions: @instructions

    }
    #@preptime
  end
end
