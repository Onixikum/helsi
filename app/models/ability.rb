# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :all

    return unless user.is_a?(AdminUser)

    can :read, AdminUser
    can :manage, ActiveAdmin::Comment
    can :manage, Category
    can :manage, Specialization
    can %i[read update destroy], Doctor
    can %i[read update destroy], User
  end
end
