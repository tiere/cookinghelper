class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new

    3.times { step = @recipe.steps.build }
    3.times { ingredient = @recipe.ingredients.build }
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :category_id,
      ingredient_ids: [],
      steps_attributes: [:id, :name, :duration, :_destroy],
      ingredients_attributes: [:id, :quantity, :foodstuff_id, :unit_id, :recipe_id, :_destroy]
    )
  end
end
