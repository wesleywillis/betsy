class ModifyShipped < ActiveRecord::Migration
  def change
    change_table :posts do |t|
        remove_column :author_name
        add_column :writer_id, :integer
    end
  end
end
