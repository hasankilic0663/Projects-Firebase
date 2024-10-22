//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Hasan Hüseyin Kılıç on 19.10.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
class UploadVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        uploadImageView.isUserInteractionEnabled = true// tıklanabilir yapıyoruz
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        uploadImageView.addGestureRecognizer(tapGesture)
        
        
    }
    

    @objc func choosePicture(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true,completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func uploadClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        if let data =  uploadImageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
               if error != nil {
                   self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
               }else{
                   imageReferance.downloadURL() { (url, error) in
                       if error == nil {
                           let imageURL = url?.absoluteString// burada stringe cevirip laıyoz
                           //Firestore
                           let fireStore = Firestore.firestore()
                           //onu bul demek
                           fireStore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.username).getDocuments(){snapshot,error in
                               if error != nil {
                                   self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
                                   
                               }else {
                                   if snapshot?.isEmpty == false  {
                                       for document in snapshot!.documents {
                                           let documentID = document.documentID
                                           if var imageUrlArray = document.get("imageUrlArray") as? [String] {
                                               imageUrlArray.append(imageURL!)
                                               
                                               let additionalDictionary = ["imageUrlArray":imageUrlArray] as [String : Any]
                                               
                                               fireStore.collection("Snaps").document(documentID).setData(additionalDictionary, merge: true ){ error in
                                                   if error == nil {
                                                       self.tabBarController?.selectedIndex = 0
                                                       self.uploadImageView.image = UIImage(named: "select")
                                                   }
                                                   
                                               }
                                           }
                                           
                                       }
                                   }
                                   else {
                                       let snapDictionary : [String: Any] = [
                                        "imageUrlArray": [imageURL!],
                                        "snapOwner": UserSingleton.sharedUserInfo.username ,
                                        "date" : FieldValue.serverTimestamp()
                                        
                                       ]
                                       
                                       fireStore.collection("Snaps").addDocument(data: snapDictionary) { (error) in
                                           if error != nil {
                                               self.makeAlert(title: "ERROR", message:  error?.localizedDescription ?? "Error")
                                           }else{
                                               self.tabBarController?.selectedIndex = 0
                                               self.uploadImageView.image = UIImage(named: "select")
                                           }
                                       }
                                   }
                               }
                               
                           }
                           
                           
                           
                           
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
}
