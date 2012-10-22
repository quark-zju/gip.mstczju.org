class AddContentPreviewToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :content_preview, :text
  end
end
