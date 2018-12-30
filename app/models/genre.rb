class Genre < BasicRecord::Base001
  belongs_to :category

  validates :title, :category_id, presence: {}
end
