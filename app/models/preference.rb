class Preference < BasicRecord::Base001
  has_many :preference_contents
  has_many :seminars, through: :preference_contents
  validates :title, presence: {}
end
