class CreateRecipesIngredients < ActiveRecord::Migration
  def change
    create_table :recipes_ingredients do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
    end
  end
end
