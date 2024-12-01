require 'open-uri'
require 'json'

# Nettoyer les données existantes
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

# Récupérer des films via l'API
url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

movies['results'].first(100).each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

# Créer des listes par défaut
List.create!(name: 'Drama')
List.create!(name: 'Comedy')
List.create!(name: 'Sci-Fi')
