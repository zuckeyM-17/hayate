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

ActiveRecord::Schema[7.2].define(version: 2024_07_07_155500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.integer "category", default: 0, null: false
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_books_on_title", unique: true
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "chapters", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.string "title", null: false
    t.integer "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_chapters_on_book_id"
  end

  create_table "daily_task_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "disabled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_daily_task_items_on_user_id"
  end

  create_table "daily_task_sets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_daily_task_sets_on_user_id"
  end

  create_table "daily_tasks", force: :cascade do |t|
    t.bigint "daily_task_set_id", null: false
    t.bigint "daily_task_item_id", null: false
    t.boolean "done", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_task_item_id"], name: "index_daily_tasks_on_daily_task_item_id"
    t.index ["daily_task_set_id"], name: "index_daily_tasks_on_daily_task_set_id"
  end

  create_table "favorite_links", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "link_id", null: false
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_favorite_links_on_link_id"
    t.index ["user_id"], name: "index_favorite_links_on_user_id"
  end

  create_table "link_notes", force: :cascade do |t|
    t.bigint "link_id", null: false
    t.bigint "note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_link_notes_on_link_id"
    t.index ["note_id"], name: "index_link_notes_on_note_id"
  end

  create_table "links", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "url"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "reading_notes", force: :cascade do |t|
    t.bigint "reading_id", null: false
    t.bigint "note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_reading_notes_on_note_id"
    t.index ["reading_id"], name: "index_reading_notes_on_reading_id"
  end

  create_table "readings", force: :cascade do |t|
    t.bigint "chapter_id", null: false
    t.datetime "done_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_readings_on_chapter_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "priority", default: 0, null: false
    t.integer "category", default: 0, null: false
    t.datetime "due_at"
    t.datetime "done_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "display_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "word_searches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_word_searches_on_user_id"
    t.index ["word_id"], name: "index_word_searches_on_word_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "en", null: false
    t.string "ja", null: false
    t.string "pronunciation_symbol", null: false
    t.string "meaning", null: false
    t.json "misc", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["en"], name: "index_words_on_en", unique: true
  end

  add_foreign_key "books", "users"
  add_foreign_key "chapters", "books"
  add_foreign_key "daily_task_items", "users"
  add_foreign_key "daily_task_sets", "users"
  add_foreign_key "daily_tasks", "daily_task_items"
  add_foreign_key "daily_tasks", "daily_task_sets"
  add_foreign_key "favorite_links", "links"
  add_foreign_key "favorite_links", "users"
  add_foreign_key "link_notes", "links"
  add_foreign_key "link_notes", "notes"
  add_foreign_key "links", "users"
  add_foreign_key "notes", "users"
  add_foreign_key "reading_notes", "notes"
  add_foreign_key "reading_notes", "readings"
  add_foreign_key "readings", "chapters"
  add_foreign_key "tasks", "users"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "word_searches", "users"
  add_foreign_key "word_searches", "words"
end
