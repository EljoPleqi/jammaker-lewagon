class Instruction < ApplicationRecord
  belongs_to :recipe

  def self.parse(instructions)
    @instructions = []
    instructions.split("Step").each do |instruction|
      @instructions << instruction
    end
    return @instructions
  end
end
