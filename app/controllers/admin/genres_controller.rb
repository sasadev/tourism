class Admin::GenresController < Admin::BaseController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :destroy

  def index
    query = params
    search_remained(query)
    @genres, @query = GenreSearchForm.generate_objects(admin_query_params, admin_user: @current_admin_user)
  end

  def search
  end

  def show
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    sort = Genre.last.try(:sort_seq)
    if sort.present?
      @genre.sort_seq = (sort.to_i + 1)
    else
      @genre.sort_seq = 1
    end
    if @genre.save
      redirect_to edit_admin_genre_path(@genre), notice: t('activerecord.flash.genre.actions.create.success')
    else
      flash.now[:alert] = t('activerecord.flash.genre.actions.create.failure')
      render :new
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to edit_admin_genre_path(@genre), notice: t('activerecord.flash.genre.actions.update.success')
    else
      flash.now[:alert] = t('activerecord.flash.genre.actions.update.failure')
      render :edit
    end
  end

  def destroy
    if @genre.soft_delete
      redirect_to admin_genres_path, notice: t('activerecord.flash.genre.actions.destroy.success')
    else
      flash[:alert] = t('activerecord.flash.genre.actions.destroy.failure')
      redirect_to admin_genres_path
    end
  end

  def sort
    if request.post?
      begin
        Genre.transaction do
          params[:genre_contents].each.with_index(1) do |genre_id,i|
            genre = Genre.find_by(id: genre_id)
            genre.sort_seq = i

            genre.save
          end
        end
        flash[:notice] = t('activerecord.flash.genre.actions.sort_seq.success')
      rescue => e
        p e
        flash[:alert] = t('activerecord.flash.genre.actions.sort_seq.failure')
      end
    end

    redirect_to action: :index
  end

  private
  def set_genre
    @genre = Genre.find_by(id: params[:id])
  end

  def genre_params
    params.require(:genre).permit!
  end
end