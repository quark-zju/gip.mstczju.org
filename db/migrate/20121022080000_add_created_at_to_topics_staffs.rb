class AddCreatedAtToTopicsStaffs < ActiveRecord::Migration

  def up
    [:listeners, :lecturers].each do |name|
      # SQLite does not support alter column default value
      # and can not add column with CURRENT_TIMESTAMP as default.

      # create temperatory table and copy, drop, rename
      execute <<"EOS"
CREATE TABLE "#{name}_temp" ("staff_id" integer NOT NULL, "topic_id" integer NOT NULL, "created_at" DATETIME DEFAULT CURRENT_TIMESTAMP)
EOS

      # copy content of old table
      execute "INSERT INTO #{name}_temp (staff_id, topic_id) SELECT staff_id, topic_id FROM #{name}"

      # replace old table
      execute "DROP TABLE #{name}"
      execute "ALTER TABLE #{name}_temp RENAME TO #{name}"

      # create index
      add_index name, :created_at

      # Attention: following CURRENT_TIMESTAMP will be quoted, this is not wanted.
      # t.datetime :created_at, null: false, default: 'CURRENT_TIMESTAMP'
    end
  end

  def down
    [:listeners, :lecturers].each do |name|
      remove_index name, :created_at
      remove_column name, :created_at
    end
  end

end
