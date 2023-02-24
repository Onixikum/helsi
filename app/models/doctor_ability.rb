# frozen_string_literal: true

class DoctorAbility < Ability
  def initialize(user)
    return unless user.is_a?(Doctor)

    can :read, :show
    can :index, Appointment
    can :update, Appointment, user: user
    can %i[read history], User
  end
end
