class AddDimensionsToProducts < ActiveRecord::Migration
  def change
    add_column(:products, :dimensions, :string)
  end
end
