//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Hasan Hüseyin Kılıç on 19.10.2024.
//

import UIKit
import Firebase
import FirebaseAuth
class SignInVC: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var usernameText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton(type: .roundedRect)
             button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
             button.setTitle("Test Crash", for: [])
             button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
             view.addSubview(button)
    }
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
         let numbers = [0]
         let _ = numbers[1]
     }
    @IBAction func signInClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" && emailText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text! , password: passwordText.text!) { result, error in
                
                    if  error != nil  {
                    self.makeAlert(title: "Error", message: error?.localizedDescription  ?? "error")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" && emailText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!){ auth, error in
                if  error != nil  {
                    self.makeAlert(title: "Error", message: error?.localizedDescription  ?? "error")
                }else {
                    
                    let firestore = Firestore.firestore()
                    let userDictionary = ["email" : self.emailText.text! , "username": self.usernameText.text!] as [String : Any]
                    
                    firestore.collection("UserInfo").addDocument(data: userDictionary) { error in
                        if error != nil {
                            
                        }
                        
                    }
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
                
            }
            
        }
        else {
            makeAlert(title: "Error", message: "Please fill all fields")
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

