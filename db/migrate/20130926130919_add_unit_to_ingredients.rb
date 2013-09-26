class AddUnitToIngredients < ActiveRecord::Migration
  def change
    add_reference :ingredients, :unit, index: true
  end
end
