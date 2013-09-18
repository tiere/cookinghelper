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

    create_table :ingredients_recipes do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
    end
  end
end
