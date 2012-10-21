class CreateLecturersAndListeners < ActiveRecord::Migration

  def up

    change_table :topics do |t|
      # cached columns
      t.integer :lecturer_count, null: false, default: 0
      t.integer :listener_count, null: false, default: 0
    end

    change_table :topics do |t|
      # for quick sorting
      t.index :lecturer_count
      t.index :listener_count
    end

    [:lecturers, :listeners].each do |name|
      create_table(name) do |t|
        t.references :staff, null: false
        t.references :topic, null: false
      end

      change_table(name) do |t|
        t.index :staff_id
        t.index :topic_id
      end
    end

  end

  def down

    remove_column :topics, :listener_count
    remove_column :topics, :lecturer_count

    [:lecturers, :listeners].each do |name|
      drop_table name
    end

  end

end
