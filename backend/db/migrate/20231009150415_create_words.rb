class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :word
      t.text  :mean,limit:4294967295
      t.timestamps
    end
  end
end
