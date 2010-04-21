class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, :required => true, :length => 256
      t.string :body, :length => 8 * 1024
      t.string :content_type, :length => 16, :default => 'text/html'
      t.string :state, :length => 16, :default => 'published'
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
