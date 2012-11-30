class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :url
      t.string :original_url
      t.string :file_name
      t.timestamps
    end
  end
end
