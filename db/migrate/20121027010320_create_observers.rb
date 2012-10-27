class CreateObservers < ActiveRecord::Migration
  def up

    [:observers].each do |name|
      create_table(name) do |t|
        t.references :staff, null: false
        t.references :topic, null: false
      end

      change_table(name) do |t|
        t.index :staff_id
        t.index :topic_id
        t.index [:staff_id, :topic_id], unique: true
      end
    end

  end

  def down

    [:observers].each do |name|
      drop_table name
    end

  end
end
