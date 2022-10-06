class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, Recipe
    can :destroy, Recipe, user: user
    can :modify, Recipe, user: user
    can :modify, User, id: user.id

    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
