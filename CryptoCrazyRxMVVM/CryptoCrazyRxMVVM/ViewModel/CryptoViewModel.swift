//
//  CryptoViewModel.swift
//  CryptoCrazyRxMVVM
//
//  Created by Hasan Hüseyin Kılıç on 22.10.2024.
//

import Foundation
import RxSwift
import RxCocoa


class CryptoViewModel{
    
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<Error> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
   func requestData(){
       self.loading.onNext(true)
        
       let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
       WebService().downloadCurrencies(url: url) { result in
           self.loading.onNext(false)// buraya gırdıgı an false yapacagız
           switch result {
           case .success(let cryptos):
               self.cryptos.onNext(cryptos)
//               self.cryptoList = cryptos
//               // veri geldikten sonra arka planda yapılmamalı bursda
//               DispatchQueue.main.async {
//                   self.tableView.reloadData()
//               }
               // BURADA ARTIKL RXSwift KUllanacagız
               
                
               print(cryptos)
               
              
           case .failure(let error):
               switch error {
               case .parsinError:
                   self.error.onNext("Parsing Error" as! Error )
               case .serverError:
                   self.error.onNext("Server Error" as! Error )
                   
               }
           }
       } 
       
    }
    
}
