class CreateVideoFiles < ActiveRecord::Migration
  def self.up
    create_table :video_files do |t|
      t.string :name
      t.string :url
      t.string :webm_url
      t.integer :story_id

      t.string :job_id #zencoder job id
      t.string :encoded_state, :default => "unencoded"
      #t.string :output_url
      t.integer :duration_in_ms
      t.string :aspect_ratio

      t.timestamps
    end
  end

  def self.down
    drop_table :video_files
  end
end
