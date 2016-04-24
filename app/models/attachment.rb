class Attachment < ActiveRecord::Base
  belongs_to :note

  has_attached_file :file

  validates_attachment :file,
    presence: true,
    content_type: { content_type: [
      /\Avideo/,
      /\Aimage/,
      /\Atext/,
      /pdf\Z/,      
      'application/msword',
      'application/vnd.ms-excel',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'application/x-download',
      'application/octet-stream'
    ] },
    size: { less_than: 300.kilobytes }
end