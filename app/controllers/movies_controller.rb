require 'open-uri'
require 'json'

class MoviesController < ApplicationController
  def search
    if params[:query].present?
      url = "https://tmdb.lewagon.com/3/search/movie?query=#{URI.encode_www_form_component(params[:query])}"
      begin
        movies_serialized = URI.open(url).read
        @movies = JSON.parse(movies_serialized)['results']
      rescue OpenURI::HTTPError => e
        @movies = []
        flash.now[:alert] = "Error searching movies: #{e.message}"
      end
    else
      @movies = []
    end
  end
end
