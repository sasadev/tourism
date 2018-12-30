class InsertCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :color, :string, comment: '色'

    [['アート', '#1E90FF'], ['飲食', '#FFFFCC	'], ['自然', '#CCFFCC'], ['ファッション', '#990033	'], ['有名な観光地', '#9900FF']].each.with_index(1) do |objects, i|
      category = Category.find_or_initialize_by(title: objects[0], color: objects[1])
      category.sort_seq = i

      category.save!
    end
  end
end
