class AddIngredientToRecipes < ActiveRecord::Migration
  def change
    add_reference :recipes, :ingredient, index: true
  end
end
