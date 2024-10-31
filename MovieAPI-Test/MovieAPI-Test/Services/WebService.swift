//
//  WebService.swift
//  MovieAPI-Test
//
//  Created by Hasan Hüseyin Kılıç on 28.10.2024.
//

import Foundation


class Webservice{
    
    func filmleriIndir(url : URL , completion : @escaping ([Movie]?) -> ()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error  = error{
                print(error.localizedDescription)
                completion(nil)
            } else if let  data = data{
                let filmlerDizisi = try? JSONDecoder().decode(MovieResponse.self, from: data) //hangi sınıftan yapacagımızı sordugu ıcın self diyoruz.
                
                if let filmlerDizisi = filmlerDizisi{
                    completion(filmlerDizisi.Search)
                    
                }
                
            }
        }.resume() // başlatmak ıcın kullanıcaz
        
        
    }
    
}
