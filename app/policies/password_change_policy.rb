class PasswordChangePolicy < ApplicationPolicy
  def create?
    signed_in?
  end
end