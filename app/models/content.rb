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

  class << self
    def _create_contents
      path = "#{Rails.root}/file/contents/tourism_contents.csv"
      pluck_category   = Category.alive_records.pluck(:title, :id).to_h
      pluck_genre      = Genre.alive_records.pluck(:title, :id).to_h
      pluck_prefecture = Prefecture.pluck(:name, :id).to_h
      pluck_preference = Preference.pluck(:title, :id).to_h

      CSV.foreach(path, headers: false, encoding: "SJIS:UTF-8").each.with_index do |row, i|
        next if i == 0
        row_= row.map{|d|
          d ||= ""
          d}
        query = {}
        row_0 = row_[0]
        query[:title] = row_0
        row_1 = pluck_category[row_[1]]
        query[:category_id] = row_1
        row_2 = pluck_genre[row_[2]]
        query[:genre_id] = row_2
        row_3 = row_[3] == 'yes' ? 1 : 0
        query[:event] = row_3
        Dir.glob("#{Rails.root}/file/contents/images/*").each do |file_path|
          file_name = File.basename(file_path, '.*')
          if row_[4].include?(file_name)
            query[:main_image] = open(file_path)
          end
        end
        row_5 = row_[5]
        query[:index_description] = row_5
        row_6 = row_[6]
        query[:description] = row_6
        row_7 = row_[7].to_i
        query[:time_required] = row_7
        row_8 = row_[8] == 'インドア' ? 0 : 1
        query[:activity] = row_8
        row_9 = row_[9]
        query[:period_from] = row_9
        row_10 = row_[10]
        query[:period_to] = row_10
        row_11 = row_[11]
        query[:recommended] = row_11
        row_12 = row_[12].to_i
        query[:zip] = row_12
        row_13 = pluck_prefecture[row_[13]]
        query[:prefecture_id] = row_13
        row_14 = row_[14]
        query[:address] = row_14
        row_15 = row_[15]
        query[:building] = row_15
        row_16 = row_[16]
        query[:memo] = row_16
        row_17 = row_[17].to_i
        query[:amount] = row_17
        preference_titles = row_[21].split('.')
        row_21s = []
        preference_titles.each do |title|
          row_21s << pluck_preference[title]
        end
        query[:preference_ids] = row_21s

        content = Content.new(query)

        p content.save
      end
    end
  end
end
