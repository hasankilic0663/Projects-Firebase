//
//  ViewController.swift
//  XiBLearning-UIKit
//
//  Created by Hasan Hüseyin Kılıç on 8.11.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var view1: CustomView2!
    
    @IBOutlet weak var view3: CustomView2!
    @IBOutlet weak var view2: CustomView2!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Configure each view
               view1.configureView(title: "Tc Kimlik Numaranız", placeholder: "Tc Kimlik Numaranızı Giriniz", errorLabel: "11 Haneli olması gerekiyor")
               view2.configureView(title: "Adınız", placeholder: "Adınızı Giriniz", errorLabel: "Adınızı girmeniz zorunludur")
               view3.configureView(title: "Soyadınız", placeholder: "Soyadınızı Giriniz", errorLabel: "Soyadınızı girmeniz zorunludur")
               
               // Validate the text fields
              
            }
    
    // Ad alanı doğrulaması
  

    @IBAction func buttonControll(_ sender: Any) {
        
        view1.validateTextField(view1.denemeTextField, errorLabel: view1.errorLabel, errorMessage: "Lütfen Tc Kimlik numaranızı girin.")
        view2.validateTextField(view2.denemeTextField, errorLabel: view2.errorLabel, errorMessage: "Lütfen adınızı girin.")
        view3.validateTextField(view3.denemeTextField, errorLabel: view3.errorLabel, errorMessage: "Lütfen soyadınızı girin.")
        
    }
    

}

