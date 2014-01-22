module RecipesHelper
  def owner_of_recipe(recipe)
    recipe.user == current_user
  end

  def contains_editable_recipes(recipes)
    recipes.each do |recipe|
      if recipe.user == current_user
        return true
      end
    end

    false
  end
end
