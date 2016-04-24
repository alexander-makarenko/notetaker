class Note < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, dependent: :destroy

  validates :title,       presence: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 1000 }

  def attachments=(attachments)
    attachments.try(:each) { |attachment| self.attachments.build(file: attachment) }
  end
end