class AddModelsToDb < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string 'username', null: false
      t.string 'email', null: false
      t.string 'password_digest'
      t.string 'uid'
      t.string 'provider'
      t.timestamps
    end
  end
end
