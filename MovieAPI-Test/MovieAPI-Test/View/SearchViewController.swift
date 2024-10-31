//
//  SearchViewController.swift
//  MovieAPI-Test
//
//  Created by Hasan Hüseyin Kılıç on 30.10.2024.
//

import UIKit

class SearchViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate{
    
    
    private var moviesTableViewModel: MoviesTableViewModel!
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Movies"
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
        
    }
    // Search işlemi başlatıldığında
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           if searchText.count > 2 { // 2 karakterden fazlaysa aramaya başla
               veriAl(query: searchBar.text!)
           }else if  searchText.count<=2{
               // Eğer arama metni boşsa movieResults dizisini temizle ve tabloyu güncelle
               if moviesTableViewModel != nil {
                   moviesTableViewModel.clearResults()
                   DispatchQueue.main.async {
                               self.tableView.reloadData() // Boş durumda tabloyu yeniden yükle
                           }
               }
              
           }
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = self.moviesTableViewModel.newsAtIndexPath(indexPath.row)
        print("\(selectedMovie.imdbID)")
        let imdbID  = selectedMovie.imdbID
      
        //segue baslangıcı
        performSegue(withIdentifier: "showMovieDetailSegue",sender: imdbID )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetailSegue"{
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

    func veriAl(query : String){
        let url = URL(string: "https://omdbapi.com/?apikey=2f14edc2&s=\(query)")
   
        Webservice().filmleriIndir(url: url!) { filmler in
            if let filmler = filmler {
               print("\(filmler) slşkdfşslad")
                
                self.moviesTableViewModel = MoviesTableViewModel(newsList: filmler)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // otomatık yukseklık ıcın
        return 200
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
