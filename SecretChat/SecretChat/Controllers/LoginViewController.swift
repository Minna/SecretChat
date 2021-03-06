//
//  LoginViewController.swift
//  SecretChat
//
//  Created by Minna on 24/04/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
           
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
              
                if let e = error{
                    print(e.localizedDescription)
                }else
                {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
                
            }
        }
        
      
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
