class AddPostsToDb < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
    t.string 'attachment'
    t.text 'content'
    t.integer 'user_id', null: false
    t.index ['user_id'], name: 'index_posts_on_user_id'
    t.timestamps
    end
  end
end
