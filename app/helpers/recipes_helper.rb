module RecipesHelper
  def owner_of_recipe(recipe)
    recipe.user == current_user
  end

  def contains_editable_recipes(recipes)
    recipes.each do |recipe|
      return true if recipe.user == current_user
    end

    false
  end
end
