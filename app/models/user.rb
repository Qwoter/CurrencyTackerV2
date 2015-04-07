class User < ActiveRecord::Base
  has_many :countries
  has_many :currencies

  before_create do |user|
    user.api_key = user.generate_api_key if user.api_key.blank?
  end

  def generate_api_key
    loop do
      token = SecureRandom.hex
      break token unless User.exists?(api_key: token)
    end
  end
end
