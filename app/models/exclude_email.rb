# frozen_string_literal: true

module ExcludeEmail
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
