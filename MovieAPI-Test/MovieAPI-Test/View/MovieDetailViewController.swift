//
//  MovieDetailViewController.swift
//  MovieAPI-Test
//
//  Created by Hasan Hüseyin Kılıç on 31.10.2024.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    var imdbID: String?
    @IBOutlet weak var year: UILabel!

    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imdbID = imdbID {
            veriAl(imdbID: imdbID)
        }
        
        
        
    }
    
    func veriAl(imdbID: String){
        let url = URL(string: "https://www.omdbapi.com/?apikey=2f14edc2&i=\(imdbID)")
   
        Webservice().filmleriDetayliIndir(url: url!) { filmler in
            DispatchQueue.main.async {
                if let filmler = filmler {
                    print("\(filmler) slşkdfşslad")
                    
                    self.year.text = filmler.year
                    self.actorLabel.text = filmler.actors
                    self.runTimeLabel.text = filmler.runtime
                    self.writerLabel.text = filmler.writer
                    self.titleLabel.text = filmler.title
                    self.directorLabel.text = filmler.director
                    
                    
                    
                    if let posterURL = filmler.poster, let url = URL(string: posterURL) {
                                       self.loadImage(from: url)
                                   } else {
                                       self.imageView.image = UIImage(named: "defaultPoster") // Varsayılan resim
                                   }
                }
            }
        }
    }
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
