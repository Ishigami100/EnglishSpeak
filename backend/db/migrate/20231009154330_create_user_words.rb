class CreateUserWords < ActiveRecord::Migration[7.0]
  def change
    create_table :user_words do |t|
      t.integer :word_number
      t.string :username
      t.integer :count
      t.timestamps
    end
  end
end
