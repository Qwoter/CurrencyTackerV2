class AddIndexesCountriesCurrencies < ActiveRecord::Migration
  def self.up
    add_index :countries, :user_id, :name => "country_user_id_idx"
    add_index :countries, [:code, :user_id], :name => "country_code_user_id_idx"

    add_index :currencies, :user_id, :name => "currency_user_id_idx"
    add_index :currencies, :country_id, :name => "currency_country_id_idx"
    add_index :currencies, [:code, :user_id], :name => "currency_code_user_id_idx"
  end

  def self.down
    remove_index :countries, name: :country_user_id_idx
    remove_index :countries, name: :country_code_user_id_idx
    
    remove_index :currencies, name: :currency_user_id_idx
    remove_index :currencies, name: :currency_country_id_idx
    remove_index :currencies, name: :currency_code_user_id_idx
  end
end
