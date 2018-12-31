class Front::ContentsController < Front::BaseController
  def tour_select
    @contents = Content.alive_records
  end
end