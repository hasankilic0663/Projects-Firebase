//
//  News.swift
//  MovieAPI-Test
//
//  Created by Hasan Hüseyin Kılıç on 28.10.2024.
//

import Foundation

struct MovieResponse: Codable {
   
    let Search: [Movie]
}

struct Movie: Codable {
    let title, year, rated, released: String?
       let runtime, genre, director, writer: String?
       let actors, plot, language, country: String?
       let awards: String?
       let poster: String?
       
       let metascore, imdbRating, imdbVotes, imdbID: String?
       let type, dvd, boxOffice, production: String?
       let website, response: String?

       enum CodingKeys: String, CodingKey {
           case title = "Title"
           case year = "Year"
           case rated = "Rated"
           case released = "Released"
           case runtime = "Runtime"
           case genre = "Genre"
           case director = "Director"
           case writer = "Writer"
           case actors = "Actors"
           case plot = "Plot"
           case language = "Language"
           case country = "Country"
           case awards = "Awards"
           case poster = "Poster"
           
           case metascore = "Metascore"
           case imdbRating, imdbVotes, imdbID
           case type = "Type"
           case dvd = "DVD"
           case boxOffice = "BoxOffice"
           case production = "Production"
           case website = "Website"
           case response = "Response"
       }
}


//
//struct Search: Codable {
//    let Search: [Movie]
//}
