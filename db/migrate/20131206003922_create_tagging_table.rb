class CreateTaggingTable < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :shortened_url_id
      t.integer :tag_topic_id

      t.timestamps
    end

    add_index :taggings, [:shortened_url_id, :tag_topic_id]
  end
end
