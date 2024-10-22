//
//  WebService.swift
//  CryptoCrazyRxMVVM
//
//  Created by Hasan Hüseyin Kılıç on 22.10.2024.
//

import Foundation

enum CryptoError: Error {
    case serverError
    case parsinError // VERİ GELDİ AMA BEN ONU PARSE EDEMEDIM GIBI BI HATA
}

class WebService {


    func downloadCurrencies(url : URL , completion: @escaping (Result<[Crypto],CryptoError>) -> () )  { // escapingiş bittikten sonra calıstırılacak demek
        URLSession.shared.dataTask(with: url) { data, response, error in
            if  let _ = error {
               //completion(.failure(CryptoError.serverError))
                completion(.failure(.serverError))
            }else if let data = data {
               let cryptoList = try?  JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                }else{
                    completion(.failure(.parsinError))
                }
                    
            }
        }.resume()
    }
}
