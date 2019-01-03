class Destination < BasicRecord::Base001
  obfuscatable spin: 89238723

  enum visit: { v_none: 0, v_first: 1, v_second: 2, v_more: 3 }
  enum stay: { s_none: 0, s_first: 1, s_second: 2, s_more: 3 }
  enum sex: { male: 0, female: 1 }
  enum number_people: { n_first: 0, n_second: 1, n_third: 2, n_more: 3 }
  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, a_more: 5 }

  has_many :destination_transportations
  has_many :transportations, through: :destination_transportations
  has_many :destination_contents
  has_many :contents, through: :destination_contents

  accepts_nested_attributes_for :destination_transportations, allow_destroy: true
  accepts_nested_attributes_for :destination_contents, allow_destroy: true
end
