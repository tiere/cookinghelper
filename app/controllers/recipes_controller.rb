class RecipesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new

    3.times { step = @recipe.steps.build }
    3.times { ingredient = @recipe.ingredients.build }
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      flash[:success] = "Recipe created"
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

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :category_id,
      ingredient_ids: [],
      steps_attributes: [:id, :name, :_destroy, :duration_h, :duration_m, :duration_s],
      ingredients_attributes: [:id, :quantity, :foodstuff_id, :unit_id, :recipe_id, :_destroy]
    )
  end
end