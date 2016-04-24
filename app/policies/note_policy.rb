class NotePolicy < ApplicationPolicy
  def index?
    signed_in?
  end

  def show?
    signed_in? && owner?
  end

  def create?
    signed_in?
  end

  def update?
    signed_in? && owner?
  end

  def destroy?
    signed_in? && owner?
  end

  private

    def owner?      
      record.user_id == user.id
    end
end