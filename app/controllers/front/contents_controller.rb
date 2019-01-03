class Front::ContentsController < Front::BaseController
  before_action :authenticate!

  def index
    params[:query] ||= {}

    search_query = {
        title: params[:query][:title],
        prefecture_id: params[:query][:prefecture_id],
        price_check: params[:query][:price_check],
        category_id: params[:query][:category_id],
        preference_ids: params[:query][:preference_ids],
    }
    @contents, @query = FrontContentSearchForm.generate_objects(query: search_query)
  end

  def show
    @content = Content.find_by(id: params[:id])
  end
end