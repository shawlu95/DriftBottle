//
//  ViewController.swift
//  DriftBottle
//
//  Created by main on 2023/12/9.
//

import UIKit

class ViewController: UIViewController {

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
                    print("Text to send: \(textToSend)")
                }
            }

            // Add the action to the alert controller
            alertController.addAction(sendAction)

            // Present the alert controller
            present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

