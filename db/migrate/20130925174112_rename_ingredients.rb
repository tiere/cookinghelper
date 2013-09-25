class RenameIngredients < ActiveRecord::Migration
  def change
    rename_table :ingredients, :foodstuffs
  end
end
