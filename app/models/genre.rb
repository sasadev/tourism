class Genre < BasicRecord::Base001
  belongs_to :category
  has_many :contents

  validates :title, :category_id, presence: {}
end
