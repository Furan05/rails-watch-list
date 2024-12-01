import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value
      if (query.length >= 2) {
        fetch(`/movies/search?query=${query}`, {
          headers: { "Accept": "application/json" }
        })
        .then(response => response.json())
        .then(data => {
          this.resultsTarget.innerHTML = this.buildResults(data)
          this.resultsTarget.classList.remove('d-none')
        })
      } else {
        this.resultsTarget.classList.add('d-none')
      }
    }, 300)
  }

  buildResults(movies) {
    return movies.slice(0, 5).map(movie => `
      <div class="search-result p-2 d-flex align-items-center border-bottom">
        <img src="https://image.tmdb.org/t/p/w92${movie.poster_path}"
             class="me-2"
             style="width: 45px; height: 67px; object-fit: cover;">
        <div>
          <strong>${movie.title}</strong>
          <small class="text-muted d-block">${movie.release_date}</small>
        </div>
      </div>
    `).join('')
  }
}
