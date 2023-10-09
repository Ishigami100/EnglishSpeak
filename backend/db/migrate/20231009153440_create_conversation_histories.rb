class CreateConversationHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :conversation_histories do |t|
      t.string :username
      t.text :context
      t.integer :conversation_times
      t.boolean :gpt_flag
      t.timestamps
    end
  end
end
