//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Hasan Hüseyin Kılıç on 19.10.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SDWebImage
class FeedVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    

    @IBOutlet weak var tableView: UITableView!
    let firestoreData = Firestore.firestore()
    var snapArray: [Snap] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        getSnapsFromFirebase()
        
        getUserInfo()
    }
    
    func getSnapsFromFirebase() {
        firestoreData.collection("Snaps").order(by: "date" , descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
            }else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.snapArray.removeAll()
                    for document in snapshot!.documents {
                        let documentId = document.documentID
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("İmageUrlarray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue() , to: Date()).hour {
                                        if difference >= 24 {
                                            //Delete
                                            self.firestoreData.collection("Snaps").document(document.documentID).delete { error in
                                                
                                            }
                                        }
                                        //Tımeleft -> SnapVC
                                    }// kaydedılen dateten suankı date ı cıkarıp kac saat ldugunu soyluyo
                                    let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue())
                                    self.snapArray.append(snap)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getUserInfo () {
        firestoreData.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments{ (snapshot, error) in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
            }else{
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                       if let username = document.get("username") as? String {
                           UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                           UserSingleton.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
    }
    
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:   indexPath) as! FeedCell
        cell.feedUserName.text = snapArray[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        return cell
    }
    
}
