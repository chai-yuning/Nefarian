class CreateQuests < ActiveRecord::Migration
  def self.up
    create_table :quests do |t|
      t.integer :user_id
      t.integer :quest_id
      t.integer :status

      t.timestamps
    end
    add_index :quests, :user_id
    add_index :quests, :created_at
  end

  def self.down
    drop_table :quests
  end
end
