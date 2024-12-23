//
//  CustomView2.swift
//  XiBLearning-UIKit
//
//  Created by Hasan Hüseyin Kılıç on 8.11.2024.
//

import UIKit

@IBDesignable

final class CustomView2: UIView {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet  var denemeTextField: UITextField!
    @IBOutlet var denemeLabel: UILabel!
    
    @IBInspectable var title: String? {
           didSet {
               denemeLabel.text = title
           }
       }
       
       @IBInspectable var placeholder: String? {
           didSet {
               denemeTextField.placeholder = placeholder
           }
       }
       
       @IBInspectable var errorMessage: String? {
           didSet {
               errorLabel.text = errorMessage
           }
       }
       
    
    override  init(frame: CGRect) {
        super .init(frame: frame)
        self.configureView()
    
        
    }
    
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureView()
    }
    
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "CustomView2")
                else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        
        borderView.layer.borderColor = UIColor.systemGray3.cgColor
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = 4
        borderView.layer.masksToBounds = true
        errorLabel.isHidden = true
    }
   
    
    func configureView(title : String ,placeholder : String , errorLabel : String){
        self.denemeLabel.text = title
        self.denemeTextField.placeholder = placeholder
        self.errorLabel.text = errorLabel
     
    }
    
  
       
       func validateTextField(_ textField: UITextField, errorLabel: UILabel, errorMessage: String) {
           // Check if the text field is empty
           if textField.text?.isEmpty ?? true {
               errorLabel.isHidden = false
               errorLabel.text = errorMessage
               borderView.layer.borderColor = UIColor.red.cgColor
               borderView.layer.borderWidth = 1
               borderView.layer.cornerRadius = 4
               borderView.layer.masksToBounds = true
               denemeTextField.attributedPlaceholder = NSAttributedString(
                    string: denemeTextField.placeholder ?? "",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
                )
               
           } else {
               errorLabel.isHidden = true
             
               borderView.layer.borderColor = UIColor.systemGray3.cgColor
               borderView.layer.borderWidth = 1
               borderView.layer.cornerRadius = 4
               borderView.layer.masksToBounds = true
               denemeTextField.attributedPlaceholder = NSAttributedString(
                    string: denemeTextField.placeholder ?? "",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
                )
           }
       }
   

}
