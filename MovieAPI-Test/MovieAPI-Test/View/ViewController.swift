//
//  ViewController.swift
//  MovieAPI-Test
//
//  Created by Hasan Hüseyin Kılıç on 28.10.2024.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
 
    @IBOutlet weak var tableView: UITableView!
    
    private var moviesTableViewModel: MoviesTableViewModel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            self.view.backgroundColor = .black
            
        tableView.dataSource = self
        tableView.delegate = self
//            tableView.rowHeight = UITableView.automaticDimension
//            tableView.estimatedRowHeight = UITableView.automaticDimension// automatıc yapıyoz burda heıghtı
//            
            
            tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
            
            
            veriAl()
        
    }
    
    func veriAl(){
        let url = URL(string: "https://www.omdbapi.com/?s=movie&apikey=2f14edc2")
   
        Webservice().filmleriIndir(url: url!) { filmler in
            if let filmler = filmler {
               print("\(filmler) slşkdfşslad")
                
                self.moviesTableViewModel = MoviesTableViewModel(moviesList: filmler)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = self.moviesTableViewModel.newsAtIndexPath(indexPath.row)
        print("\(selectedMovie.imdbID)")
        let imdbID  = selectedMovie.imdbID
      
        //segue baslangıcı
        performSegue(withIdentifier: "showMovieDetail",sender: imdbID )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail"{
            let destinationVC = segue.destination as! MovieDetailViewController
            if let imdbID = sender as? String{
                destinationVC.imdbID = imdbID
               
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesTableViewModel == nil ? 0 : moviesTableViewModel.numberofRowsInSection() // boş gelirse diye
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let  cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell{
            // cell.titleLabel
            let moviesViewModel = self.moviesTableViewModel.newsAtIndexPath(indexPath.row)
            
            cell.titleLabel.text = moviesViewModel.title
            cell.yearLabel.text = moviesViewModel.year
            loadImage(from: moviesViewModel.poster) { image in
                DispatchQueue.main.async {
                    cell.customImageView?.image = image
                    cell.setNeedsLayout() // Resmin yüklendiğinde hücrenin düzenini yenile
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // otomatık yukseklık ıcın
        return 250
    }
//
    
    
    
    
     func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }

}

