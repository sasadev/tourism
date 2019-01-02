class FrontContentSearchForm < SearchForm
  attr_accessor :deleted
  attr_accessor :category_id
  attr_accessor :price_check
  attr_accessor :preference_ids

  equal_attributes :prefecture_id

  like_attributes :title

  def custom_hook(scoped)
    scoped = scoped.alive_records

    if category_id.present?
      scoped = scoped.where(category_id: category_id.to_i)
    else
      categories = Category.alive_records.reorder(sort_seq: :asc)
      category = categories.first

      scoped = scoped.where(category_id: category.id)
    end

    if price_check.present?
      price_chek = PriceRange.find_by(id: price_check.to_i)
      scoped = scoped.where("amount <= ?", price_chek&.end_price)
    end

    preference_ids.reject! { |i| i.blank? } if preference_ids.present?
    if preference_ids.present?
      scoped = scoped.where("contents.id IN (SELECT content_id FROM preference_contents WHERE preference_id in (?) ) ", preference_ids)
    end

    scoped.order(event: :desc, id: :desc)
  end
end
