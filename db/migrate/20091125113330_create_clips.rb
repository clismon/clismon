class CreateClips < ActiveRecord::Migration
  def self.up
    create_table :clips do |t|
      t.string :name
      t.string :group, :length => 40
      t.integer :position
      t.integer :width, :default => 0
      t.integer :height, :default => 0
      t.string :media_file_name
      t.string :media_content_type
      t.integer :media_file_size
      t.datetime :media_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :clips
  end
end
