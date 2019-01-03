class Transportation < BasicRecord::Base001
  validates :title, presence: {}

  has_many :destination_transportations
  has_many :destinations, through: :destination_transportations
  accepts_nested_attributes_for :destinations, allow_destroy: true
end
