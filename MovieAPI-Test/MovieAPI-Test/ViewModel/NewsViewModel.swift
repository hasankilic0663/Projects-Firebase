//
//  NewsViewModel.swift
//  MovieAPI-Test
//
//  Created by Hasan Hüseyin Kılıç on 28.10.2024.
//

import Foundation


struct MoviesTableViewModel {
    let newsList: [Movie]
    
    
}

extension MoviesTableViewModel {
    func numberofRowsInSection() -> Int {
        return self.newsList.count
    }
    
    func newsAtIndexPath(_ index: Int) -> MoviesViewModel {
        let movies = self.newsList[index]
        return MoviesViewModel(movies: movies)
        
    }
}


struct MoviesViewModel {
    let movies: Movie
    
    var title: String {
        return self.movies.title
    }
    
    var year: String {
        return self.movies.year
    }
    var poster: String {
           return movies.poster
       }
}
