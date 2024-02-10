# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_131_083_913) do
  create_table 'messages', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'room_id', null: false
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['room_id'], name: 'index_messages_on_room_id'
    t.index ['user_id'], name: 'index_messages_on_user_id'
  end

  create_table 'noticed_events', force: :cascade do |t|
    t.string 'type'
    t.string 'record_type'
    t.integer 'record_id'
    t.json 'params'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'notifications_count'
    t.index %w[record_type record_id], name: 'index_noticed_events_on_record'
  end

  create_table 'noticed_notifications', force: :cascade do |t|
    t.string 'type'
    t.integer 'event_id', null: false
    t.string 'recipient_type', null: false
    t.integer 'recipient_id', null: false
    t.datetime 'read_at', precision: nil
    t.datetime 'seen_at', precision: nil
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_noticed_notifications_on_event_id'
    t.index %w[recipient_type recipient_id], name: 'index_noticed_notifications_on_recipient'
  end

  create_table 'participants', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'room_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['room_id'], name: 'index_participants_on_room_id'
    t.index ['user_id'], name: 'index_participants_on_user_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'attachment'
    t.text 'content'
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'relationships', force: :cascade do |t|
    t.integer 'follower_id'
    t.integer 'followee_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'rooms', force: :cascade do |t|
    t.string 'name'
    t.boolean 'is_private', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username', null: false
    t.string 'email', null: false
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'uid'
    t.string 'provider'
  end

  create_table 'votes', force: :cascade do |t|
    t.string 'votable_type'
    t.integer 'votable_id'
    t.string 'voter_type'
    t.integer 'voter_id'
    t.boolean 'vote_flag'
    t.string 'vote_scope'
    t.integer 'vote_weight'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[votable_id votable_type vote_scope],
            name: 'index_votes_on_votable_id_and_votable_type_and_vote_scope'
    t.index %w[votable_type votable_id], name: 'index_votes_on_votable'
    t.index %w[voter_id voter_type vote_scope], name: 'index_votes_on_voter_id_and_voter_type_and_vote_scope'
    t.index %w[voter_type voter_id], name: 'index_votes_on_voter'
  end

  add_foreign_key 'messages', 'rooms'
  add_foreign_key 'messages', 'users'
  add_foreign_key 'participants', 'rooms'
  add_foreign_key 'participants', 'users'
  add_foreign_key 'posts', 'users'
end
