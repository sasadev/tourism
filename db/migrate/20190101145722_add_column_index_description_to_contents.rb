class AddColumnIndexDescriptionToContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :index_description, :text, comment: '一覧説明文'
  end
end
