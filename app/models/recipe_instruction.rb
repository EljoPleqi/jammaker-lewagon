class RecipeInstruction < ApplicationRecord
  belongs_to :instructions
  belongs_to :recipe
end
