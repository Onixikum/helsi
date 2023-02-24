# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :welcome

    merge user_ability(user)
  end

  private

  def user_ability(user)
    user_ability_class = "#{user.class}Ability".constantize
    user_ability_class.new(user)
  end
end
