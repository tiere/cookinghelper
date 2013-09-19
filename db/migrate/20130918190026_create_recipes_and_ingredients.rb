class CreateRecipesAndIngredients < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.timestamps
    end

    create_table :ingredients do |t|
      t.string :name
      t.timestamps
    end

    create_table :ingredients_recipes, id: false do |t|
      t.references :ingredient
      t.references :recipe
    end
  end
end
