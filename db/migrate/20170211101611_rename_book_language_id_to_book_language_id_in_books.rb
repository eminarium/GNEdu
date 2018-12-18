class RenameBookLanguageIdToBookLanguageIdInBooks < ActiveRecord::Migration
  def change
    rename_column :books, :bookLanguage_id, :book_language_id
  end
end
