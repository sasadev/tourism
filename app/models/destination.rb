class Destination < BasicRecord::Base001
  obfuscatable spin: 89238723
  after_validation :start_geocode
  after_validation :end_geocode

  enum visit: { v_none: 0, v_first: 1, v_second: 2, v_more: 3 }
  enum stay: { s_none: 0, s_first: 1, s_second: 2, s_more: 3 }
  enum sex: { male: 0, female: 1 }
  enum number_people: { n_first: 0, n_second: 1, n_third: 2, n_more: 3 }
  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, a_more: 5 }

  belongs_to :start_prefecture, foreign_key: 'start_prefecture_id', class_name: 'Prefecture'
  belongs_to :end_prefecture, foreign_key: 'end_prefecture_id', class_name: 'Prefecture'
  has_many :destination_transportations
  has_many :transportations, through: :destination_transportations
  has_many :destination_contents
  has_many :contents, through: :destination_contents

  accepts_nested_attributes_for :destination_transportations, allow_destroy: true
  accepts_nested_attributes_for :destination_contents, allow_destroy: true

  validates :start_zip, :end_zip, :start_address, :end_address, :start_prefecture_id, :end_prefecture_id, :departure, :arrival, presence: {}

  def start_full_address
    full_address = "%s %s"%([self.start_prefecture&.name,self.start_address])
    return full_address
  end

  def end_full_address
    full_address = "%s %s"%([self.end_prefecture&.name,self.end_address])
    return full_address
  end

  def start_geocode
    uri = "https://maps.googleapis.com/maps/api/geocode/json?new_forward_geocoder=true&address="+self.start_full_address.gsub(" ", "")+"&key=AIzaSyB24ipjMmo0c4e47nEEaOevMYodjl9PGhs"
    res = HTTP.get(uri).to_s
    response = JSON.parse(res)
    self.start_latitude = response['results'][0]['geometry']['location']['lat']
    self.start_longitude = response['results'][0]['geometry']['location']['lng']
  end

  def end_geocode
    uri = "https://maps.googleapis.com/maps/api/geocode/json?new_forward_geocoder=true&address="+self.end_full_address.gsub(" ", "")+"&key=AIzaSyB24ipjMmo0c4e47nEEaOevMYodjl9PGhs"
    res = HTTP.get(uri).to_s
    response = JSON.parse(res)
    self.end_latitude = response['results'][0]['geometry']['location']['lat']
    self.end_longitude = response['results'][0]['geometry']['location']['lng']
  end
end
