class AddUserToRecipies < ActiveRecord::Migration[6.1]
  def change
    add_reference :recipies, :user, null: false, foreign_key: true
  end
end
