//
import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var buttonControll: UIButton!
    // Outlets
    @IBOutlet weak var errordate: UILabel!
    @IBOutlet weak var errorLabel1: UILabel!
    @IBOutlet weak var yearPicker: UIDatePicker!
    @IBOutlet weak var selectedYearLabel: UILabel!
    @IBOutlet weak var stackViewCheckbox: UIStackView!
    @IBOutlet weak var veritextfield: UITextField!
    @IBOutlet weak var selectedCheckboxButton: UIButton!
    @IBOutlet weak var deneme: UILabel!
    
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var errorLabel2: UILabel!
    var isChecked = false
    override func viewDidLoad() {
        super.viewDidLoad()
        errordate.isHidden = true
        //setupYearPicker()
        updateYearLabel(with: yearPicker.date)
        
        errorLabel1.isHidden = true
        buttonControll.layer.backgroundColor = UIColor.black.cgColor
        buttonControll.layer.cornerRadius = 4
        
        
        
        veritextfield.delegate = self
   
        
    }
    
    @IBAction func checkBoxButton(_ sender: Any) {
        
        isChecked.toggle()
        selectedCheckboxButton.setImage(isChecked ? UIImage(systemName: "checkmark.square") : UIImage(systemName:  "checkmark.square.fill"), for: .normal)
        
        if isChecked == true {
            stackViewCheckbox.layer.borderColor = UIColor.red.cgColor
            stackViewCheckbox.layer.borderWidth = 1
            
            stackViewCheckbox.layer.cornerRadius = 4
            errorLabel2.isHidden = false
        }else{
            stackViewCheckbox.layer.borderColor = UIColor.gray.cgColor
            stackViewCheckbox.layer.borderWidth = 1
            
            stackViewCheckbox.layer.cornerRadius = 4
            errorLabel2.isHidden = true
        }
    }
    

    // Tarih değiştiğinde çağrılacak action
    @IBAction func yearChanged(_ sender: UIDatePicker) {
        updateYearLabel(with: sender.date)
        validateDateOfBirth(sender.date)
    }
    
    private func updateYearLabel(with date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Sadece yılı göster
        selectedYearLabel.text = "Seçilen Yıl: \(formatter.string(from: date))"
    }
    
    @IBAction func buttonControl(_ sender: Any) {
        validate()
        
    }
    
    private func validateDateOfBirth(_ selectedDate: Date) {
           let calendar = Calendar.current
           let currentDate = Date()
           let age = calendar.dateComponents([.year], from: selectedDate, to: currentDate).year ?? 0
           
           // Eğer yaş 18'den küçükse
           if age < 18 {
               yearPicker.layer.borderColor = UIColor.red.cgColor
               yearPicker.layer.borderWidth = 2
               errordate.isHidden = false
           } else {
               yearPicker.layer.borderColor = UIColor.gray.cgColor
               yearPicker.layer.borderWidth = 1
               errordate.isHidden = true
           }
       }
    func validate(){
        if veritextfield.text?.isEmpty == true{
            veritextfield.layer.borderColor = UIColor.red.cgColor
            veritextfield.layer.borderWidth = 1
            namelabel.textColor = UIColor.red
            veritextfield.layer.cornerRadius = 4
            errorLabel1.isHidden = false
            
        }
        else{
            errorLabel1.isHidden = true
            veritextfield.layer.borderColor = UIColor.systemGray4.cgColor
            veritextfield.layer.cornerRadius = 4
            veritextfield.layer.borderWidth = 1
            namelabel.textColor = UIColor.black
            
            
        }
        
    }
}
