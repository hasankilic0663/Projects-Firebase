//
//  SecondViewController.swift
//  SelectorApp
//
//  Created by Hasan Hüseyin Kılıç on 6.11.2024.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tcErrorLabel: UILabel!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var surnameErrorLabel: UILabel!
    @IBOutlet weak var birthdayErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
        @IBOutlet weak var checkboxErrlrLabel: UILabel!
    var isChecked = false
    @IBOutlet weak var stackViewCheckbox: UIStackView!
    
    @IBOutlet weak var calendarImageView: UIImageView!
    @IBOutlet weak var selectedCheckboxButton: UIButton!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var surnameView: UIView!

    @IBOutlet weak var tcView: UIView!
    @IBOutlet weak var birthdayUIView: UIView!
    private var datePicker : UIDatePicker!
    
    @IBOutlet weak var tcTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var birthDayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker?.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        let imageViewBottom = calendarImageView.frame.origin.y
        datePicker.frame = CGRect(x: 100, y: surnameView.frame.maxY + 250 , width: self.view.frame.width - 180, height: 280)
                    self.view.addSubview(datePicker)
                
        datePicker.backgroundColor = .white
                // Başlangıçta gizli
                datePicker.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDatePicker))
        calendarImageView.isUserInteractionEnabled = true
        calendarImageView.addGestureRecognizer(tapGesture)
        
//        let screenTapGesture = UITapGestureRecognizer(target: self, action: #selector(closeDatePicker))
//               self.view.addGestureRecognizer(screenTapGesture)
// 
        birthDayTextField.isEnabled = false
       
    }
    
    @objc func openDatePicker(){
          // Takvimi animasyonlu şekilde göster
          UIView.animate(withDuration: 0.3) {
              self.datePicker.isHidden = false
              self.datePicker.alpha = 1.0
          }
      }

      @objc func closeDatePicker() {
          // Takvimi gizle
          UIView.animate(withDuration: 0.3) {
              self.datePicker.alpha = 0.0
          } completion: { _ in
              self.datePicker.isHidden = true
          }
      }

    @objc func datePickerValueChanged(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthDayTextField.text = formatter.string(from: datePicker.date)
        datePicker.isHidden = true
    }
  
    
    @IBAction func checkBoxButton(_ sender: Any) {
        
        isChecked.toggle()
        selectedCheckboxButton.setImage(isChecked ? UIImage(systemName: "checkmark.square") : UIImage(systemName:  "checkmark.square.fill"), for: .normal)
        
        if isChecked == true {
            
            checkboxErrlrLabel.isHidden = false
        }else{
            
            checkboxErrlrLabel.isHidden = true
        }
    }
    

    @IBAction func buttonController(_ sender: Any) {
        validate()
    }
    
    func validate(){
        ColorError(textfiled: tcTextField, uiView: tcView, errorLabel: tcErrorLabel, errormessage: "Lütfen TC Kimlik Numaranızı Giriniz")
        ColorError(textfiled: surnameTextField, uiView: surnameView, errorLabel: surnameErrorLabel, errormessage: "Lütfen Soyadınızı Giriniz")
        ColorError(textfiled: nameTextField, uiView: nameView, errorLabel: nameErrorLabel, errormessage: "Unicode name is not valid")
        ColorError(textfiled: birthDayTextField, uiView: birthdayUIView, errorLabel: birthdayErrorLabel, errormessage: "Lütfen Doğum Tarihinizi Giriniz")
        
        if let birthDateText = birthDayTextField.text, !birthDateText.isEmpty {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    
                    if let birthDate = formatter.date(from: birthDateText) {
                        let currentDate = Date()
                        let calendar = Calendar.current
                        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
                        
                        if let age = ageComponents.year, age < 18 {
//                            ColorError(textfiled: birthDayTextField, uiView: birthdayUIView, errorLabel: birthdayErrorLabel, errormessage: "18 Yaşından Küçük bir değer girmemelisiniz", isConditionMet: true)
                            birthdayUIView.layer.borderColor = UIColor.red.cgColor
                            birthdayUIView.layer.borderWidth = 1
                            birthdayErrorLabel.textColor = UIColor.red
                            birthdayErrorLabel.text = "18 yaşından küçük bir değer girmemelisiniz"
                            birthdayUIView.layer.cornerRadius = 4
                            birthdayErrorLabel.isHidden = false
                            //bu asagıdakı kod placeholder rengını degıstırıyo
                            birthDayTextField.attributedPlaceholder = NSAttributedString(
                                 string: birthDayTextField.placeholder ?? "",
                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
                             )
                        } else {
                            birthdayErrorLabel.isHidden = true
                            birthdayUIView.layer.borderColor = UIColor.systemGray4.cgColor
                            birthdayUIView.layer.cornerRadius = 4
                            birthdayUIView.layer.borderWidth = 1
                            //bu asagıdakı kod placeholder rengını degıstırıyo
                            birthDayTextField.attributedPlaceholder = NSAttributedString(
                                 string: birthDayTextField.placeholder ?? "",
                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
                             )
                        }
                    }
                } else {
                    closeDatePicker()
                }
            }
        //        if nameTextField.text?.isEmpty == true{
//            nameView.layer.borderColor = UIColor.red.cgColor
//            nameView.layer.borderWidth = 1
//            nameErrorLabel.textColor = UIColor.red
//            nameView.layer.cornerRadius = 4
//            nameErrorLabel.isHidden = false
//            //bu asagıdakı kod placeholder rengını degıstırıyo
//             nameTextField.attributedPlaceholder = NSAttributedString(
//                 string: nameTextField.placeholder ?? "",
//                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
//             )
//            
//        }
//        else{
//            nameErrorLabel.isHidden = true
//            nameView.layer.borderColor = UIColor.systemGray4.cgColor
//            nameView.layer.cornerRadius = 4
//            nameView.layer.borderWidth = 1
//            //bu asagıdakı kod placeholder rengını degıstırıyo
//             nameTextField.attributedPlaceholder = NSAttributedString(
//                 string: nameTextField.placeholder ?? "",
//                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
//             )
//        }
        
    
    

}


func ColorError(textfiled: UITextField , uiView: UIView! , errorLabel: UILabel, errormessage: String/*,isConditionMet: Bool*/ ) {
    
    if textfiled.text?.isEmpty == true  {
        uiView.layer.borderColor = UIColor.red.cgColor
        uiView.layer.borderWidth = 1
        errorLabel.textColor = UIColor.red
        errorLabel.text = errormessage
        uiView.layer.cornerRadius = 4
        errorLabel.isHidden = false
        //bu asagıdakı kod placeholder rengını degıstırıyo
        textfiled.attributedPlaceholder = NSAttributedString(
             string: textfiled.placeholder ?? "",
             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
         )
        
    }
    else{
        errorLabel.isHidden = true
        uiView.layer.borderColor = UIColor.systemGray4.cgColor
        uiView.layer.cornerRadius = 4
        uiView.layer.borderWidth = 1
        //bu asagıdakı kod placeholder rengını degıstırıyo
        textfiled.attributedPlaceholder = NSAttributedString(
             string: textfiled.placeholder ?? "",
             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
         )
    }
}
