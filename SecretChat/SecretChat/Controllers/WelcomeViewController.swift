//
//  WelcomeViewController.swift
//  SecretChat
//
//  Created by Minna on 24/04/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
  
    override func viewWillDisappear (_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLetter =  K.appName
        titleLabel.text = ""
        var charachterIndex = 0
        for char in titleLetter{

            charachterIndex+=1
            Timer.scheduledTimer(withTimeInterval: Double(charachterIndex)*0.1, repeats: false) { (Timer) in
                self.titleLabel.text?.append(char)
            }
        }
    }
    

   

}
