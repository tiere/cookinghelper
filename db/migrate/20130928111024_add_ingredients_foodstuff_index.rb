class AddIngredientsFoodstuffIndex < ActiveRecord::Migration
  def change
    add_index :ingredients, :foodstuff_id
  end
end
