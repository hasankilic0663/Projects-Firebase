//
//  NewsViewModel.swift
//  MovieAPI-Test
//
//  Created by Hasan Hüseyin Kılıç on 28.10.2024.
//

import Foundation


struct MoviesTableViewModel {
    var moviesList: [Movie]
    
    
}
extension MoviesTableViewModel {
    mutating func clearResults() {
        moviesList.removeAll()
    }
}

extension MoviesTableViewModel {
    func numberofRowsInSection() -> Int {
        return self.moviesList.count
    }
    
    func newsAtIndexPath(_ index: Int) -> MoviesViewModel {
        let movies = self.moviesList[index]
        return MoviesViewModel(movies: movies)
        
    }
}


struct MoviesViewModel {
    let movies: Movie
    
    var title: String {
        return self.movies.title ?? "N/A"
    }
    
    var year: String {
        return self.movies.year ?? "N/A"
    }
    var poster: String {
        return movies.poster ?? "N/A"
       }
    
    var imdbID: String {
        return movies.imdbID ?? "N/A"
       }
    var director: String {
        return movies.director ?? "N/A"
    }
}
