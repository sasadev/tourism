class Category < BasicRecord::Base001
  has_many :genres
  has_many :contents

  validates :title, :color, presence: {}
end
