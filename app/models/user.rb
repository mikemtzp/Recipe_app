class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy

  validates :name, presence: true, length: { minimum: 0, maximum: 50 }

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

    [all_ingredients.flatten!, all_ingredients_price]
  end

  def new_ingredients_information
    all_ingredients, _all_ingredients_price = user_recipes_information
    new_ingredients = []
    new_ingredients_price = 0
    list_foods.each do |food|
      ingredients_quantity = 0
      ingredients = all_ingredients.select { |e| e.food_id == food.id }
      next if ingredients.empty?

      ingredients.each do |i|
        ingredients_quantity += i.quantity
      end

      new_ingredient_quantity = ingredients_quantity - food.quantity
      new_ingredient_price = (ingredients_quantity * food.price) - food.total_price

      if new_ingredient_quantity.positive?
        new_ingredients.push({ name: food.name, quantity: new_ingredient_quantity, price: new_ingredient_price })
        new_ingredients_price += new_ingredient_price
      end
    end
    [new_ingredients, new_ingredients_price]
  end
end
