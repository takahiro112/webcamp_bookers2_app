class ChangeFavoritesColimns < ActiveRecord::Migration[5.2]
  def change

    add_column :favorites, :favorite_user_id, :integer
    add_column :favorites, :favorite_book_id, :integer
    remove_column :favorites, :user, :references
    remove_column :favorites, :book, :references

  end
end
