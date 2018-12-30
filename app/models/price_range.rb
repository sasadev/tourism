class PriceRange < BasicRecord::Base001
  validates :title, presence: true
  validates :begining_price, :end_price, numericality: true
end
