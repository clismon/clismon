class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name, :required => true
      t.string :title, :required => true
      t.string :color, :required => true, :default => '#000'
      t.boolean :section, :default => true
      t.references :background
      t.timestamps
    end

    add_index :groups, :name
  end

  def self.down
    drop_table :groups
  end
end
