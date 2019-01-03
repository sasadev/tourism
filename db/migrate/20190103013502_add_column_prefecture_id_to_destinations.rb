class AddColumnPrefectureIdToDestinations < ActiveRecord::Migration[5.0]
  def change
    add_column :destinations, :start_zip, :integer, comment: '郵便番号'
    add_column :destinations, :end_zip, :integer, comment: '郵便番号'

    add_column :destinations, :start_address, :text, comment: '住所'
    add_column :destinations, :end_address, :text, comment: '住所'

    add_column :destinations, :start_building, :text, comment: '建物名'
    add_column :destinations, :end_building, :text, comment: '建物名'

    add_column :destinations, :start_prefecture_id, :integer, comment: '都道府県ID'
    add_column :destinations, :end_prefecture_id, :integer, comment: '都道府県ID'
  end
end
