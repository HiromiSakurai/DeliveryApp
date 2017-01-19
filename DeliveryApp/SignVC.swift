//
//  SignVC.swift
//  DeliveryApp
//
//  Created by 櫻井寛海 on 2017/01/15.
//  Copyright © 2017年 櫻井寛海. All rights reserved.
//

import UIKit

class SignVC: UIViewController {
    
   // private let MAIN_SEGUE = "MainSegue"
    
    //var signVc: SignVC?
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func logIn(_ sender: Any) {
//        if emailTextfield.text != "" && passwordTextfield.text != "" {
//            
//            AuthProvider.Instance.login(withEmail: emailTextfield.text!, password: passwordTextfield.text!, loginHandler: { (message) in
//                
//                if message != nil {
//                    self.alertTheUser(title: "Ploblem with Authentication", message: message!)
//                } else {
//                    self.emailTextfield.text = ""
//                    self.passwordTextfield.text = ""
//                    self.performSegue(withIdentifier: self.MAIN_SEGUE, sender: nil)
//                    
//                    print("Log In Success")
//                }
//            })
//            
//        } else {
//            alertTheUser(title: "Email and Password are required!", message: "Please enter your email & password")
//        }
        let layout = UICollectionViewFlowLayout()
        let homeController = HomeController(collectionViewLayout: layout)
        navigationController?.pushViewController(homeController, animated: true)
        
        //print(navigationController)
        print("log in!")
    }
    
    @IBAction func signUp(_ sender: Any) {
        if emailTextfield.text != "" && passwordTextfield.text != "" {
            
            AuthProvider.Instance.signUp(withEmail: emailTextfield.text!, password: passwordTextfield.text!, loginHandler: { (message) in
                if message != nil {
                    self.alertTheUser(title: "Ploblem With Creating A New User", message: message!)
                } else {
                    self.emailTextfield.text = ""
                    self.passwordTextfield.text = ""
                    //self.performSegue(withIdentifier: self.MAIN_SEGUE, sender: nil)
                    
                    print("Sign Up Success")
                }
            })
            
        } else {
            alertTheUser(title: "Email and Password are required!", message: "Please enter your email & password")
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
