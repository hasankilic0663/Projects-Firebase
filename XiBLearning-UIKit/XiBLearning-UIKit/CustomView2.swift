//
//  CustomView2.swift
//  XiBLearning-UIKit
//
//  Created by Hasan Hüseyin Kılıç on 8.11.2024.
//

import UIKit

@IBDesignable
final class CustomView2: UIView {

    @IBOutlet  var denemeTextField: UITextField!
    @IBOutlet var denemeLabel: UILabel!
    override  init(frame: CGRect) {
        super .init(frame: frame)
        self.configureView()
    }
    
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
//        guard let view = self.loadViewFromNib(nibName: "CustomView2")
//                else { return }
//        view.frame = self.bounds
//        self.addSubview(view)
        
        // Çerçeve için özellikler
        self.layer.borderColor = UIColor.systemGray3.cgColor
          self.layer.borderWidth = 1
          self.layer.cornerRadius = 4
          self.layer.masksToBounds = true
    }
   
    
    func configureView(title : String){
        self.denemeLabel.text = title
     
    }
    

}
