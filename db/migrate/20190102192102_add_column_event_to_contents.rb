class AddColumnEventToContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :event, :integer, default: 0, null: false, comment: '時事イベント'

    create_table :preference_contents do |t|
      t.integer :content_id, comment: 'コンテンツID'
      t.integer :preference_id, comment: '好みiD'
      t.timestamps
    end
    add_index :preference_contents, :content_id
    add_index :preference_contents, :preference_id
  end
end
