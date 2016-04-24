class AttachmentPolicy < ApplicationPolicy
  def download?
    signed_in? && owner?
  end

  def destroy?
    signed_in? && owner?
  end

  private

    def owner?
      record.note.user_id == user.id
    end
end