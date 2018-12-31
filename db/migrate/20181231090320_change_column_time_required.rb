class ChangeColumnTimeRequired < ActiveRecord::Migration[5.0]
  def change
    remove_column :contents, :time_required, :string, comment: '所用時間'
    remove_column :contents, :activity, :integer, comment: '室内外'
    remove_column :contents, :recommended, :string, comment: 'おすすめポイント'
    remove_column :contents, :content_image_id, :integer, comment: 'コンテンツ画像ID'

    add_column :contents, :time_required, :integer, comment: '所用時間'
    add_column :contents, :activity, :integer, default: 0, null: false, comment: '室内外'
    add_column :contents, :recommended, :text, comment: 'おすすめポイント'
    add_column :content_images, :content_id, :integer, comment: 'コンテンツID'
  end
end
