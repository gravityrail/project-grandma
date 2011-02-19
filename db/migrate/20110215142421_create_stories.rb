class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :title, :null => false
      t.text :description
      t.integer :owner_id, :null => false
      t.string :thumbnail_file_name
      t.string :thumbnail_content_type
      t.integer :thumbnail_file_size
      t.datetime :thumbnail_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
