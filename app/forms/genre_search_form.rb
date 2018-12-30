class GenreSearchForm < SearchForm
  attr_accessor :deleted

  like_attributes :title


  def custom_hook(scoped)
    scoped = scoped.alive_records
    scoped.order(sort_seq: :asc)
  end
end
