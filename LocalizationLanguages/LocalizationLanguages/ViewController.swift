//
//  ViewController.swift
//  LocalizationLanguages
//
//  Created by Hasan Hüseyin Kılıç on 20.11.2024.
//

import UIKit

class ViewController: UIViewController {

    private let myLabel : UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(myLabel)
        myLabel.frame = view.bounds
        
    }


}

