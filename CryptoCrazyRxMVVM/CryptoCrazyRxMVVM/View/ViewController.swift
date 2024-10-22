//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by Hasan Hüseyin Kılıç on 22.10.2024.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
    

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var cryptoList = [Crypto]()
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag() // hafızada durmamasi için çöpe çantasına atıyo

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        setupBindings()
        cryptoVM.requestData()
        
        //JSON aldıgımızda decode edebılmek
//        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
//        WebService().downloadCurrencies(url: url) { result in
//            switch result {
//            case .success(let cryptos):
//                self.cryptoList = cryptos
//                // veri geldikten sonra arka planda yapılmamalı bursda
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//               
//            case .failure(let error):
//                print(error)
//            }
//        }
         // bu yukarıdakı kısımları vıewmodelda yapmamız gerekıyor , oraya tasıdık 
    }
    
    private func setupBindings() {
        
//        cryptoVM.loading.subscribe{ bool in
//
//        }
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by:  disposeBag)
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by:disposeBag )
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }
            .disposed(by:disposeBag )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
        
        
        
    }

}

