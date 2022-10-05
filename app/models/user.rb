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

  def total_recipes_price
    sum = 0
    list_recipes.each do |recipe|
      sum += recipe.total_price
    end
    sum
  end

  def total_recipes_ingredients
    ingredients = 0
    list_recipes.each do |recipe|
      ingredients += recipe.foods.count
    end
    ingredients
  end
end
