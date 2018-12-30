class InsertPriceRange < ActiveRecord::Migration[5.0]
  def change
    [['~5000円', 0, 5000], ['~10000円', 5001, 10000], ['~20000円', 10001, 20000], ['~30000円', 20001, 30000], ['30000円以上', 30001, 1000000]].each.with_index(1) do |objects, i|
      price_range = PriceRange.find_or_initialize_by(title: objects[0], begining_price: objects[1], end_price: objects[2])
      price_range.sort_seq = i

      price_range.save!
    end
  end
end
