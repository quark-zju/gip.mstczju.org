class AddCreatedAtToTopicsStaffs < ActiveRecord::Migration

  def up
    [:listeners, :lecturers].each do |name|
      case ActiveRecord::Base.connection.adapter_name
      when /Mysql/i
        datetime_type = 'timestamp'
      else
        datetime_type = 'datetime'
      end

      # SQLite does not support alter column default value
      # and can not add column with CURRENT_TIMESTAMP as default.

      # do not use created_at to avoid name conflict
      # thus sort by data works in both :includes, and directly collection access
      # SQLite3::SQLException: no such column: listeners.created_at: SELECT "staffs"."id", "staffs"."name", "staffs"."email", "staffs"."nick", "staffs"."avatar_file_name", "staffs"."avatar_updated_at", "t0"."topic_id" AS ar_association_key_name FROM "staffs" INNER JOIN "listeners" "t0" ON "staffs"."id" = "t0"."staff_id" WHERE "t0"."topic_id" IN (30, 20, 7, 23, 31, 29, 21, 24, 12, 17, 19, 11, 13, 15, 8, 27, 28, 26, 25, 18) ORDER BY "listeners"."created_at" ASC

      # create temperatory table and copy, drop, rename
      execute <<-"EOS"
CREATE TABLE #{name}_temp (staff_id integer NOT NULL, topic_id integer NOT NULL, relation_created_at #{datetime_type} DEFAULT CURRENT_TIMESTAMP)
      EOS

      # copy content of old table
      execute "INSERT INTO #{name}_temp (staff_id, topic_id) SELECT staff_id, topic_id FROM #{name}"

      # replace old table
      execute "DROP TABLE #{name}"
      execute "ALTER TABLE #{name}_temp RENAME TO #{name}"

      # create index
      add_index name, :relation_created_at

      # Attention: following CURRENT_TIMESTAMP will be quoted, this is not wanted.
      # t.datetime :created_at, null: false, default: 'CURRENT_TIMESTAMP'
    end
  end

  def down
    [:listeners, :lecturers].each do |name|
      remove_index name, :relation_created_at
      remove_column name, :relation_created_at
    end
  end

end
