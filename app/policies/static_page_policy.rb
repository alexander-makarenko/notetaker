class StaticPagePolicy < ApplicationPolicy
  def home?
    true
  end
end