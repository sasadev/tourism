class Category < BasicRecord::Base001
  has_many :genres

  validates :title, :color, presence: {}
end
