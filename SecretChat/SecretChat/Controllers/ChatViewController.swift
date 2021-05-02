//
//  ChatViewController.swift
//  SecretChat
//
//  Created by Minna on 24/04/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    @IBOutlet weak var messageTableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    var messges = [Message]()
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
        
    }
    
    func loadMessages(){
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField)
            .addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let snapshot  =  querySnapshot?.documents{
                    self.messges = []

                    for document in snapshot {
                       
                        print("\(document.documentID) => \(document.data())")
                        
                        let data = document.data()
                        if let sender = data[K.FStore.senderField] as? String, let message = data[K.FStore.bodyField] as? String
                        {
                            self.messges.append(Message(sender: sender, messge: message))
                            
                            DispatchQueue.main.async {
                                self.messageTableView.reloadData()
                                let index = IndexPath(row: self.messges.count - 1, section: 0)
                                self.messageTableView.scrollToRow(at: index, at: .top, animated: true)
                            }

                        }
                    }
                }
                
            }
        }

        
        
    }
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
       if let messageText = messageTextField.text,
          let sender = Auth.auth().currentUser?.email{
        var ref: DocumentReference? = nil
        ref = db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField: sender,
            K.FStore.bodyField: messageText,
            K.FStore.dateField: Date().timeIntervalSince1970
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                
                self.messageTextField.text = ""
            }
        }
       }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        
      do {
        try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
        
      } catch let signOutError as NSError {
        print ("Error signing out: %@", signOutError)
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

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageTableCell
        if(Auth.auth().currentUser?.email == messges[indexPath.row].sender){
            cell.leftImage.isHidden = true
            cell.rigtImage.isHidden = false
            cell.messageBulb.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        }else{
            cell.leftImage.isHidden = false
            cell.rigtImage.isHidden = true
            cell.messageBulb.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lighBlue)
        }
        cell.messageLabel.text = messges[indexPath.row].messge
        return cell
    }
    
    
}
