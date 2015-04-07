class Currency < ActiveRecord::Base
  self.primary_key = :code

  validates :name, :code, :weight, :collector_value, presence: true
  validates :code, uniqueness: true

  belongs_to :country
  belongs_to :user

  scope :find_first, -> (code, user_id) { where({ code: code, user_id: user_id }).first }
  scope :visited_currencies_with_countries, -> (user_id) { joins(:country).where("countries.visited = ? AND currencies.user_id = ?", false, user_id) }

  def self.collected
    all.select {|currency| currency.collected? }
  end

  def self.not_collected
    all.reject {|currency| currency.collected? }
  end

  def collected?
    country.nil? ? false : country.visited?
  end
end
