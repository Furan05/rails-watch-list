class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:bookmark][:movie_id])

    @bookmark = Bookmark.new(
      list: @list,
      movie: @movie,
      comment: params[:bookmark][:comment] || "Added from search"
    )

    if @bookmark.save
      redirect_to @list, notice: 'Movie was successfully added to the list.'
    else
      redirect_to movies_search_path, alert: 'Could not add movie to the list.'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list), notice: 'Movie was successfully removed'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
