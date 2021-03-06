class AdminUser < BasicRecord::Base001
  before_save :generate_hashed_password

  attr_accessor :password, :password_confirmation

  validates :name, :email, presence: {}
  validates :password, presence: {}, length: { within: 4..20 }, on: :create
  validates :password, presence: {}, length: { within: 4..20 }, on: :update, if: :use_password?
  validates :password, confirmation: { if: :use_password? }

  def use_password?
    !password.blank?
  end

  class << self
    def authenticate(params)
      p params
      tmp = find_by(email: params[:email], deleted: 0)
      if tmp
        return tmp if tmp.hashed_password == hash_password(params[:password], tmp.salt, auth_magic)
      end
      return false
    end
  end
end
