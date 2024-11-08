//
//  SecondViewController.swift
//  SelectorApp
//
//  Created by Hasan Hüseyin Kılıç on 6.11.2024.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tcErrorLabel: UILabel!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var surnameErrorLabel: UILabel!
    @IBOutlet weak var birthdayErrorLabel: UILabel!
    
        @IBOutlet weak var checkboxErrlrLabel: UILabel!
    var isChecked = false
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        tcTextField.delegate = self
        // Do any additional setup after loading the view.
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker?.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)

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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Sadece rakamların girilmesini sağlayalım
            let allowedCharacterSet = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            // Eğer kullanıcı geçerli bir rakam giriyorsa devam et
            if allowedCharacterSet.isSuperset(of: characterSet) {
                // Karakter sayısı 11'i geçmesin
                let currentText = textField.text ?? ""
                let newLength = currentText.count + string.count - range.length
                return newLength <= 11
            } else {
                return false // Geçerli olmayan bir karakter girildiğinde engelle
            }
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
        
    }
    

    @IBAction func buttonController(_ sender: Any) {
        validate()
    }
    
    func isValidTC(_ tc: String) -> Bool {
        // TC Kimlik numarasının uzunluğunu kontrol etme
        guard tc.count == 11 else {
            return false
        }

        // TC Kimlik numarasının sadece sayılardan oluşup oluşmadığını kontrol etme
        guard tc.allSatisfy({ $0.isNumber }) else {
            return false
        }

        // TC Kimlik numarasının ilk hanesinin 0 olmaması gerekiyor
        guard let firstDigit = Int(String(tc.first!)), firstDigit != 0 else {
            return false
        }

        // İlk 9 basamağı tek ve çift olarak ayırarak toplama
        var sumOdd = 0
        var sumEven = 0
        for i in 0..<9 {
            if let digit = Int(String(tc[tc.index(tc.startIndex, offsetBy: i)])) {
                if i % 2 == 0 {
                    sumOdd += digit
                } else {
                    sumEven += digit
                }
            }
        }

        // 10. basamağı hesaplamak
        let tenthDigit = (7 * sumOdd - sumEven) % 10

        // İlk 10 basamağın toplamını hesaplamak
        var total = 0
        for i in 0..<10 {
            if let digit = Int(String(tc[tc.index(tc.startIndex, offsetBy: i)])) {
                total += digit
            }
        }

        // 11. basamağı hesaplamak
        let eleventhDigit = total % 10

        // 10. ve 11. basamakları kontrol etme
        guard let tenth = Int(String(tc[tc.index(tc.startIndex, offsetBy: 9)])),
              let eleventh = Int(String(tc[tc.index(tc.startIndex, offsetBy: 10)])) else {
            return false
        }

        return tenth == tenthDigit && eleventh == eleventhDigit
    }
    
    func validate(){
        guard let tc = tcTextField.text, tc.count == 11 else {
                    // Eğer TC Kimlik numarası 11 haneli değilse, hata mesajı göster
//                  tcErrorLabel.text = "TC Kimlik Numarası 11 haneli olmalı."
//                   tcErrorLabel.isHidden = false
//             ColorError(textfiled: tcTextField, uiView: tcView, errorLabel: tcErrorLabel, errormessage: "Lütfen TC Kimlik Numaranızı Giriniz")
        if tcTextField.text?.isEmpty == true{
            ColorError(textfiled: tcTextField, uiView: tcView, errorLabel: tcErrorLabel, errormessage: "Lütfen TC Kimlik Numaranızı Giriniz")
           
        }else{
            ColorErrorr(textfiled: tcTextField, uiView: tcView, errorLabel: tcErrorLabel, errormessage: "TC Kimlik Numarası 11 haneli olmalı.")
           
        }
            if isChecked == true {
                
                checkboxErrlrLabel.isHidden = false
            }else{
                
                checkboxErrlrLabel.isHidden = true
            }

            
            ColorError(textfiled: surnameTextField, uiView: surnameView, errorLabel: surnameErrorLabel, errormessage: "Lütfen Soyadınızı Giriniz")
            ColorError(textfiled: nameTextField, uiView: nameView, errorLabel: nameErrorLabel, errormessage: "Unicode name is not valid")
            ColorError(textfiled: birthDayTextField, uiView: birthdayUIView, errorLabel: birthdayErrorLabel, errormessage: "Lütfen Doğum Tarihinizi Giriniz")
                    return
                }

                if !isValidTC(tc) {
                    // Eğer geçerli bir TC Kimlik numarası değilse, hata mesajı göster
                    ColorErrorr(textfiled: tcTextField, uiView: tcView, errorLabel: tcErrorLabel, errormessage: "Geçersiz TC Kimlik Numarası.")
                } else {
                    // Eğer geçerli bir TC Kimlik numarası ise, hata mesajını gizle
                
                    ColorNotError(textfiled: tcTextField, uiView: tcView, errorLabel: tcErrorLabel, errormessage: "")
                    
                }
        if isChecked == true {
            
            checkboxErrlrLabel.isHidden = false
        }else{
            
            checkboxErrlrLabel.isHidden = true
        }

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
func ColorErrorr(textfiled: UITextField , uiView: UIView! , errorLabel: UILabel, errormessage: String/*,isConditionMet: Bool*/ ) {
    
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
func ColorNotError(textfiled: UITextField , uiView: UIView! , errorLabel: UILabel, errormessage: String ) {
    
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
