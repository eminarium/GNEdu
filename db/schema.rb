# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181027104327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: true do |t|
    t.string   "announcementSubject"
    t.text     "announcementBody"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_id"
  end

  add_index "announcements", ["season_id"], name: "index_announcements_on_season_id", using: :btree

  create_table "announcements_users", primary_key: "announcement_id", force: true do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "announcements_users", ["announcement_id"], name: "index_announcements_users_on_announcement_id", using: :btree
  add_index "announcements_users", ["user_id"], name: "index_announcements_users_on_user_id", using: :btree

  create_table "attendance_sheets", force: true do |t|
    t.integer  "group_id"
    t.datetime "attendanceSheetDate"
    t.text     "attendanceSheetNotes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendance_sheets", ["group_id"], name: "index_attendance_sheets_on_group_id", using: :btree

  create_table "attendances", primary_key: "contract_id", force: true do |t|
    t.integer  "attendance_sheet_id", null: false
    t.text     "attendanceNotes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "lesson_1"
    t.boolean  "lesson_2"
    t.boolean  "lesson_3"
    t.boolean  "is_sent"
  end

  add_index "attendances", ["attendance_sheet_id"], name: "index_attendances_on_attendance_sheet_id", using: :btree
  add_index "attendances", ["contract_id"], name: "index_attendances_on_contract_id", using: :btree

  create_table "audits", force: true do |t|
    t.integer  "user_id"
    t.integer  "mod_action_id"
    t.datetime "interactionDate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "obj_id"
  end

  add_index "audits", ["mod_action_id"], name: "index_audits_on_mod_action_id", using: :btree
  add_index "audits", ["user_id"], name: "index_audits_on_user_id", using: :btree

  create_table "authors", force: true do |t|
    t.string   "authorFName"
    t.string   "authorLName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors_books", primary_key: "book_id", force: true do |t|
    t.integer "author_id", null: false
  end

  add_index "authors_books", ["author_id"], name: "index_authors_books_on_author_id", using: :btree
  add_index "authors_books", ["book_id"], name: "index_authors_books_on_book_id", using: :btree

  create_table "book_contest_participants", primary_key: "contract_id", force: true do |t|
    t.integer  "book_contest_id",  null: false
    t.integer  "book_language_id", null: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_contest_participants", ["book_contest_id"], name: "index_book_contest_participants_on_book_contest_id", using: :btree
  add_index "book_contest_participants", ["book_language_id"], name: "index_book_contest_participants_on_book_language_id", using: :btree
  add_index "book_contest_participants", ["contract_id"], name: "index_book_contest_participants_on_contract_id", using: :btree

  create_table "book_contests", force: true do |t|
    t.string   "bookContestName"
    t.integer  "season_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_contests", ["season_id"], name: "index_book_contests_on_season_id", using: :btree

  create_table "book_languages", force: true do |t|
    t.string   "bookLanguageFullName"
    t.string   "bookLanguageShortName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_lends", force: true do |t|
    t.integer  "book_id"
    t.integer  "student_id"
    t.datetime "lendDateTime"
    t.boolean  "isReturned"
    t.datetime "returnDateTime"
    t.boolean  "isDamaged"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_lends", ["book_id"], name: "index_book_lends_on_book_id", using: :btree
  add_index "book_lends", ["student_id"], name: "index_book_lends_on_student_id", using: :btree

  create_table "books", force: true do |t|
    t.integer  "book_language_id"
    t.string   "bookName"
    t.string   "imageUrl"
    t.integer  "totalQuantity"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["book_language_id"], name: "index_books_on_book_language_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "cityName"
    t.integer  "state_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "contestant_books", primary_key: "book_id", force: true do |t|
    t.integer  "book_contest_id", null: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contestant_books", ["book_contest_id"], name: "index_contestant_books_on_book_contest_id", using: :btree
  add_index "contestant_books", ["book_id"], name: "index_contestant_books_on_book_id", using: :btree

  create_table "contracts", force: true do |t|
    t.integer  "seasonContractNo"
    t.integer  "season_id"
    t.integer  "group_id"
    t.integer  "student_id"
    t.integer  "discount_id"
    t.datetime "registrationDate"
    t.boolean  "isBookGiven"
    t.float    "amountPaid"
    t.boolean  "isMoneyReturned"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "discountReason"
    t.text     "moneyReturnReason"
    t.boolean  "isReserve"
    t.integer  "payment_type_id"
    t.string   "otherContractNo"
    t.string   "otherReceiptNo"
    t.integer  "special_group_id"
  end

  add_index "contracts", ["discount_id"], name: "index_contracts_on_discount_id", using: :btree
  add_index "contracts", ["group_id"], name: "index_contracts_on_group_id", using: :btree
  add_index "contracts", ["payment_type_id"], name: "index_contracts_on_payment_type_id", using: :btree
  add_index "contracts", ["season_id"], name: "index_contracts_on_season_id", using: :btree
  add_index "contracts", ["special_group_id"], name: "index_contracts_on_special_group_id", using: :btree
  add_index "contracts", ["student_id"], name: "index_contracts_on_student_id", using: :btree

  create_table "discounts", force: true do |t|
    t.string   "discountName"
    t.integer  "discountPercent"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.integer  "student_id"
    t.string   "doc_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  add_index "documents", ["student_id"], name: "index_documents_on_student_id", using: :btree

  create_table "event_types", force: true do |t|
    t.string   "event_type_title"
    t.string   "event_type_color_code"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "event_type_id"
    t.string   "event_title"
    t.datetime "event_from_datetime"
    t.datetime "event_to_datetime"
    t.boolean  "is_weekly"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree

  create_table "exams", force: true do |t|
    t.integer  "subject_id"
    t.datetime "examDate"
    t.float    "examResult"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fName"
    t.string   "lName"
    t.string   "patronymic"
    t.integer  "season_id"
    t.string   "persona_url"
    t.string   "doc_serial"
    t.string   "doc_no"
  end

  add_index "exams", ["season_id"], name: "index_exams_on_season_id", using: :btree
  add_index "exams", ["subject_id"], name: "index_exams_on_subject_id", using: :btree

  create_table "finals", primary_key: "contract_id", force: true do |t|
    t.float    "finalPoints"
    t.text     "finalNotes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_id"
  end

  add_index "finals", ["contract_id"], name: "index_finals_on_contract_id", using: :btree
  add_index "finals", ["season_id"], name: "index_finals_on_season_id", using: :btree

  create_table "group_genders", force: true do |t|
    t.string   "groupGenderFullName"
    t.string   "groupGenderShortName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_languages", force: true do |t|
    t.string   "groupLanguageFullName"
    t.string   "groupLanguageShortName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.integer  "subject_id"
    t.integer  "season_id"
    t.integer  "lesson_time_id"
    t.integer  "teacher_id"
    t.integer  "group_gender_id"
    t.integer  "group_language_id"
    t.string   "groupTitle"
    t.boolean  "isClosed"
    t.integer  "groupLimit"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["group_gender_id"], name: "index_groups_on_group_gender_id", using: :btree
  add_index "groups", ["group_language_id"], name: "index_groups_on_group_language_id", using: :btree
  add_index "groups", ["lesson_time_id"], name: "index_groups_on_lesson_time_id", using: :btree
  add_index "groups", ["season_id"], name: "index_groups_on_season_id", using: :btree
  add_index "groups", ["subject_id"], name: "index_groups_on_subject_id", using: :btree
  add_index "groups", ["teacher_id"], name: "index_groups_on_teacher_id", using: :btree

  create_table "high_schools", force: true do |t|
    t.string   "highSchoolName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_times", force: true do |t|
    t.string   "lessonTimeTitle"
    t.time     "lessonTimeFrom"
    t.time     "lessonTimeTo"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "midterms", primary_key: "contract_id", force: true do |t|
    t.integer  "midtermOrderNo", null: false
    t.float    "midtermPoints"
    t.boolean  "isReleasedFrom"
    t.text     "midtermNotes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_id"
  end

  add_index "midterms", ["contract_id"], name: "index_midterms_on_contract_id", using: :btree
  add_index "midterms", ["midtermOrderNo"], name: "index_midterms_on_midtermOrderNo", using: :btree
  add_index "midterms", ["season_id"], name: "index_midterms_on_season_id", using: :btree

  create_table "mod_actions", force: true do |t|
    t.integer  "mod_object_id"
    t.string   "modActionName"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mod_actions", ["mod_object_id"], name: "index_mod_actions_on_mod_object_id", using: :btree

  create_table "mod_actions_roles", primary_key: "mod_action_id", force: true do |t|
    t.integer  "role_id",     null: false
    t.boolean  "allowAccess"
    t.boolean  "auditTrack"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mod_actions_roles", ["mod_action_id"], name: "index_mod_actions_roles_on_mod_action_id", using: :btree
  add_index "mod_actions_roles", ["role_id"], name: "index_mod_actions_roles_on_role_id", using: :btree

  create_table "mod_objects", force: true do |t|
    t.string "modObjectName"
    t.text   "description"
    t.string "modObjectTranslation"
  end

  create_table "nationalities", force: true do |t|
    t.string   "nationalityName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.integer  "user_id"
    t.string   "noteSubject"
    t.text     "noteContent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "isPublic"
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "notes_users", primary_key: "note_id", force: true do |t|
    t.integer "user_id", null: false
  end

  add_index "notes_users", ["note_id"], name: "index_notes_users_on_note_id", using: :btree
  add_index "notes_users", ["user_id"], name: "index_notes_users_on_user_id", using: :btree

  create_table "off_days", force: true do |t|
    t.string   "off_day_title"
    t.date     "off_day_date"
    t.boolean  "is_annual"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "order_number"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "payment_types", force: true do |t|
    t.string   "paymentTypeName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "position_number"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["user_id"], name: "index_positions_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "notes"
    t.integer  "season_id"
  end

  add_index "roles", ["season_id"], name: "index_roles_on_season_id", using: :btree

  create_table "roles_users", primary_key: "user_id", force: true do |t|
    t.integer "role_id", null: false
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "rooms", force: true do |t|
    t.string   "roomFullTitle"
    t.integer  "roomCapacity"
    t.boolean  "hasProjector"
    t.boolean  "hasEboard"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "roomShortTitle"
  end

  create_table "season_tests", force: true do |t|
    t.integer  "season_id"
    t.string   "seasonTestTitle"
    t.date     "seasonTestDate"
    t.boolean  "isFinal"
    t.text     "seasonTestNotes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "season_tests", ["season_id"], name: "index_season_tests_on_season_id", using: :btree

  create_table "seasons", force: true do |t|
    t.string   "seasonTitle"
    t.datetime "seasonFromDate"
    t.datetime "seasonToDate"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seasonNo"
    t.date     "return_deadline"
  end

  create_table "settings", force: true do |t|
    t.string   "settingName"
    t.string   "settingValue"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "special_groups", force: true do |t|
    t.integer  "season_id"
    t.string   "specialGroupTitle"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "special_groups", ["season_id"], name: "index_special_groups_on_season_id", using: :btree

  create_table "special_schools", force: true do |t|
    t.string   "specialSchoolName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "stateName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.integer  "nationality_id"
    t.string   "fName"
    t.string   "lName"
    t.string   "patronymic"
    t.boolean  "gender"
    t.date     "birthDate"
    t.string   "smsMobilePhone"
    t.boolean  "isPupil"
    t.boolean  "isStudent"
    t.boolean  "isWorker"
    t.string   "faFName"
    t.string   "faLName"
    t.string   "faWorkPlace"
    t.string   "faOccupation"
    t.string   "faOfficePhone"
    t.string   "faMobilePhone"
    t.string   "maFName"
    t.string   "maLName"
    t.string   "maWorkPlace"
    t.string   "maOccupation"
    t.string   "maOfficePhone"
    t.string   "maMobilePhone"
    t.string   "workPlace"
    t.string   "occupation"
    t.string   "officePhone"
    t.string   "mobilePhone"
    t.integer  "schoolNo"
    t.string   "schoolName"
    t.integer  "schoolYear"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imageUrl"
    t.integer  "school_city_id"
    t.string   "highSpecialSchoolOther"
    t.integer  "highSpecialSchoolYear"
    t.integer  "city_id"
    t.integer  "special_school_id"
    t.integer  "high_school_id"
    t.text     "addressBody"
    t.string   "homePhone"
    t.text     "diseaseNotes"
  end

  add_index "students", ["city_id"], name: "index_students_on_city_id", using: :btree
  add_index "students", ["fName"], name: "index_students_on_fName", using: :btree
  add_index "students", ["high_school_id"], name: "index_students_on_high_school_id", using: :btree
  add_index "students", ["lName"], name: "index_students_on_lName", using: :btree
  add_index "students", ["nationality_id"], name: "index_students_on_nationality_id", using: :btree
  add_index "students", ["patronymic"], name: "index_students_on_patronymic", using: :btree
  add_index "students", ["special_school_id"], name: "index_students_on_special_school_id", using: :btree

  create_table "subject_categories", force: true do |t|
    t.string   "subjectCategoryFullName"
    t.string   "subjectCategoryShortName"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject_code"
  end

  create_table "subjects", force: true do |t|
    t.string   "subjectFullName"
    t.string   "subjectShortName"
    t.integer  "subjectLevel"
    t.float    "subjectPrice"
    t.float    "minPassingPoints"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_category_id"
  end

  add_index "subjects", ["subject_category_id"], name: "index_subjects_on_subject_category_id", using: :btree

  create_table "teachers", force: true do |t|
    t.string   "teacherFName"
    t.string   "teacherLName"
    t.string   "teacherPatronymic"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "gender"
  end

  add_index "teachers", ["user_id"], name: "index_teachers_on_user_id", using: :btree

  create_table "timetables", force: true do |t|
    t.integer  "group_id"
    t.integer  "room_id"
    t.integer  "weekday"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timetables", ["group_id"], name: "index_timetables_on_group_id", using: :btree
  add_index "timetables", ["room_id"], name: "index_timetables_on_room_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "userLogin"
    t.string   "userFName"
    t.string   "userLName"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.boolean  "isBlocked"
    t.string   "avatar_url"
  end

  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
