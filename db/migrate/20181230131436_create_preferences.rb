class CreatePreferences < ActiveRecord::Migration[5.0]
  def change
    #好みテーブル
    create_table :preferences do |t|
      t.string :title, comment: '好み名'
      t.integer :sort_seq, default: 0, null: false, comment: '並び順'
      t.integer :deleted, default: 0, null: false
      t.timestamps
    end
  end
end
