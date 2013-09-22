class CreateIngredientsRecipesIndex < ActiveRecord::Migration
  def change
    add_index :ingredients_recipes, [:ingredient_id, :recipe_id]
  end
end
