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
    let title: String
      let year: String
      let imdbID: String
      let type: String
      let poster: String

      private enum CodingKeys: String, CodingKey {
          case title = "Title"
          case year = "Year"
          case imdbID
          case type = "Type"
          case poster = "Poster"
      }
}


//
//struct Search: Codable {
//    let Search: [Movie]
//}
