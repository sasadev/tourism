class AddColumnSortSeqToDestinationContents < ActiveRecord::Migration[5.0]
  def change
    add_column :destination_contents, :sort_seq, :integer, default: 0, null: false, comment: '並び順'
  end
end
