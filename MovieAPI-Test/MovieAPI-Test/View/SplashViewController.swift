//
//  SplashViewController.swift
//  MovieAPI-Test
//
//  Created by Hasan Hüseyin Kılıç on 1.11.2024.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imageView.alpha = 0.0
        animateImage()
    }
    

    func animateImage() {
            // Yavaşça görünmesi için animasyon
        UIView.animate(withDuration: 2.0, delay: 1.0 , options : .curveEaseOut , animations: {
                self.imageView.alpha = 1.0 // Görünür hale gelsin
            }) { _ in
                // Görüntü tamamlandıktan sonra, yavaşça kaybolsun
                UIView.animate(withDuration: 1.0, delay: 1.0 , options : .curveEaseIn, animations: {
                    self.imageView.alpha = 0.0 // Kaybolsun
                }) { _ in
                    // Kaybolma tamamlandığında ana ekrana geçiş yap
                    self.transitionToMainScreen()
                }
            }
        }

        func transitionToMainScreen() {
            // Ana ekrana geçiş işlemi
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController")
            mainViewController.modalTransitionStyle = .crossDissolve // Geçiş efektini ayarla
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
