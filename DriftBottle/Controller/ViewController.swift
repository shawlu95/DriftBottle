//
//  ViewController.swift
//  DriftBottle
//
//  Created by main on 2023/12/9.
//

import UIKit

class ViewController: UIViewController {
    
    var messageModel = MessageModel()

    @IBAction func toDrop(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Your Message", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "to stranger across the ocean!"
        }

        let sendAction = UIAlertAction(title: "Send", style: .default) { [weak alertController] _ in
            if let textField = alertController?.textFields?.first, let textToSend = textField.text {
                self.messageModel.dropBottle(with: textToSend)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Code to execute when CANCEL is tapped. Leave empty if nothing specific.
        }

        alertController.addAction(sendAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @IBAction func toPickup(_ sender: UIButton) {
        messageModel.pickBottle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageModel.delegate = self
    }
}

//MARK: - MessageManagerDelegate
extension ViewController : MessageManagerDelegate {
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    func didDropBottle(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Message Sent", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                // Code to execute when OK is tapped. Leave empty if nothing specific.
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
    
    func didPickBottle(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Bottle Opened", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                // Code to execute when OK is tapped. Leave empty if nothing specific.
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
}
