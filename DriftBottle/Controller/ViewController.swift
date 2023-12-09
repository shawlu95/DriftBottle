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
        // Create the alert controller
        let alertController = UIAlertController(title: "Your Message", message: nil, preferredStyle: .alert)

        // Add a text field to the alert controller
        alertController.addTextField { (textField) in
            textField.placeholder = "to stranger across the ocean!"
        }

        // Create the send action
        let sendAction = UIAlertAction(title: "Send", style: .default) { [weak alertController] _ in
            // Retrieve the text from the text field
            if let textField = alertController?.textFields?.first, let textToSend = textField.text {
                // Handle the text. For example, send it, display it, etc.
                self.messageModel.dropBottle(with: textToSend)
            }
        }

        // Add the action to the alert controller
        alertController.addAction(sendAction)

        // Present the alert controller
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
//        let alertController = UIAlertController(title: "Message Sent", message: nil, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//            // Code to execute when OK is tapped. Leave empty if nothing specific.
//        }
//        alertController.addAction(okAction)
//        present(alertController, animated: true)
        print(message)
    }
    
    func didPickBottle(message: String) {
        print(message)
    }
}
