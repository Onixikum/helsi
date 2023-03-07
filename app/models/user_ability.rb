# frozen_string_literal: true

class UserAbility < Ability
  def initialize(user)
    return unless user.is_a?(User)

    can :read, :show
    can :read, Category
    can %i[index create], Appointment, user: user
    can :show, Doctor
  end
end
