class InsertGenre < ActiveRecord::Migration[5.0]
  def change
    category_pluck = Category.alive_records.pluck(:title, :id).to_h
    [['買い物', '有名な観光地'], ['美術館', 'アート'], ['公園', '自然'], ['丼', '飲食'], ['もんじゃ', '飲食'], ['寿司', '飲食'], ['ラーメン', '飲食'], ['肉', '飲食'], ['中華', '飲食']].each.with_index(1) do |object, i|
      genre = Genre.find_or_initialize_by(title: object[0], category_id: category_pluck[object[1]])
      genre.sort_seq = i

      genre.save!
    end
  end
end
