class ContentImage < BasicRecord::Base001
  belongs_to :content

  mount_uploader :image, ImageUploader

  validates :image, presence: {}
end
