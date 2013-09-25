class RenameIngredientsRecipes < ActiveRecord::Migration
  def change
    rename_table :ingredients_recipes, :ingredients
  end
end
