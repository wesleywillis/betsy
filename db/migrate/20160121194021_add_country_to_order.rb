class AddCountryToOrder < ActiveRecord::Migration
  def change
    add_column(:orders, :country, :string)
  end
end
