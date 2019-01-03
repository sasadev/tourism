class Content < BasicRecord::Base001
  enum activity: { indoor: 0, outdoor: 1 }

  belongs_to :category
  belongs_to :genre

  has_many :content_images
  has_many :preference_contents
  has_many :preferences, through: :preference_contents
  has_many :destination_contents
  has_many :destinations, through: :destination_contents
  accepts_nested_attributes_for :content_images, allow_destroy: true
  accepts_nested_attributes_for :destination_contents, allow_destroy: true
  accepts_nested_attributes_for :preference_contents, allow_destroy: true

  validates :title, :description, :zip, :address, :amount, :prefecture_id, :category_id, :time_required, :activity, presence: {}

  mount_uploader :main_image, ImageUploader


  def the_time_required
    "所要時間 #{time_required}分"
  end
end
