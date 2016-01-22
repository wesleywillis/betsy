class Addweighttoproduct < ActiveRecord::Migration
  def change
    add_column(:products, :weight, :integer)
  end
end
