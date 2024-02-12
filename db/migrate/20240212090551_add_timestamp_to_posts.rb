class AddTimestampToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :created_at, :datetime
    add_column :posts, :updated_at, :datetime, null: false
  end
end
