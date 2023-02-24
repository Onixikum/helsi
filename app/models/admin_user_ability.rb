# frozen_string_literal: true

class AdminUserAbility < Ability
  def initialize(user)
    return unless user.is_a?(AdminUser)

    can :read, AdminUser
    can :read, ActiveAdmin::Page, name: 'Dashboard'
    can :manage, ActiveAdmin::Comment
    can :manage, Category
    can :manage, Specialization
    can :manage, Doctor
    can :read, Appointment
    can %i[read update destroy], User
  end
end
