//
import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var yearPicker: UIDatePicker!
    @IBOutlet weak var selectedYearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupYearPicker()
        updateYearLabel(with: yearPicker.date)
    }
    
    private func setupYearPicker() {
        // Sadece yıllar arasında seçim yapılabilmesi için minimum ve maksimum tarihleri ayarla
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = -100 // 100 yıl önceye kadar
        yearPicker.minimumDate = calendar.date(byAdding: components, to: Date())
        components.year = 0 // Şimdiki yıl
        yearPicker.maximumDate = calendar.date(byAdding: components, to: Date())
    }

    // Tarih değiştiğinde çağrılacak action
    @IBAction func yearChanged(_ sender: UIDatePicker) {
        updateYearLabel(with: sender.date)
    }
    
    private func updateYearLabel(with date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy" // Sadece yılı göster
        selectedYearLabel.text = "Seçilen Yıl: \(formatter.string(from: date))"
    }
}
