class AddDetailsToCurrency < ActiveRecord::Migration
  def change
    add_column :currencies, :weight, :float
    add_column :currencies, :collector_value, :float
  end
end
