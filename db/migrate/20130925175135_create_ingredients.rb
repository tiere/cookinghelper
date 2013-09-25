class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.belongs_to :recipe
      t.belongs_to :foodstuff
      t.decimal :quantity
      t.timestamps
    end
  end
end
