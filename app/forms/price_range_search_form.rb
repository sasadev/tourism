class PriceRangeSearchForm < SearchForm
  attr_accessor :deleted

  like_attributes :title

  equal_attributes :begining_price, :end_price

  def custom_hook(scoped)
    scoped = scoped.alive_records
    scoped.order(sort_seq: :asc)
  end
end
