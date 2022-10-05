class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy

  validates :name, presence: true

  def list_foods
    Food.where(user_id: id)
  end

  def list_recipes
    Recipe.where(user_id: id)
  end

  def user_recipes_information
    all_ingredients = []
    all_ingredients_price = 0

    list_recipes.includes(:recipe_foods).each do |recipe|
      all_ingredients.push(recipe.recipe_foods)
      all_ingredients_price += recipe.total_price
    end

    return all_ingredients.flatten!, all_ingredients_price
  end

  def new_ingredients_total_price
    total_recipes_price
  end

  def new_ingredients_total_quantity

  end

  private
  def compare_food_with_ingredient(food)

  end
end
