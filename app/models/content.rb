class Content < BasicRecord::Base001
  enum activity: { indoor: 0, outdoor: 1 }
  after_validation :geocode

  belongs_to :category
  belongs_to :genre
  belongs_to :prefecture

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

  def full_address
    full_address = "%s %s"%([self.prefecture&.name,self.address])
    return full_address
  end

  def geocode
    uri = "https://maps.googleapis.com/maps/api/geocode/json?new_forward_geocoder=true&address="+self.full_address.gsub(" ", "")+"&key=AIzaSyB24ipjMmo0c4e47nEEaOevMYodjl9PGhs"
    res = HTTP.get(uri).to_s
    response = JSON.parse(res)
    self.latitude = response['results'][0]['geometry']['location']['lat']
    self.longitude = response['results'][0]['geometry']['location']['lng']
  end
end
