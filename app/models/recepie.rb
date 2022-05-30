class Recepie < ApplicationRecord
  belongs_to :instructions
  belongs_to :tags
end
