class ChangeTotalDistanceToDestinations < ActiveRecord::Migration[5.0]
  def change
    remove_column :destinations, :total_destance, :integer, default: 0, null: false, comment: "合計移動距離"

    add_column :destinations, :total_distance, :float, default: 0, null: false, comment: "合計移動距離"
  end
end
