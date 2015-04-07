class AddRelationCountriesCurrencies < ActiveRecord::Migration
  def self.up
    add_column :currencies, :user_id, :string
    add_column :countries, :user_id, :string
  end

  def self.down
    remove_column :currencies, :user_id
    remove_column :countries, :user_id
  end
end
