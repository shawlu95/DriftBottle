//
//  MessageModel.swift
//  DriftBottle
//
//  Created by main on 2023/12/9.
//

import Foundation

protocol MessageManagerDelegate {
    func didFailWithError(_ error: Error)
    func didDropBottle(message: String)
    func didPickBottle(message: String)
}

struct MessageModel {
    var delegate: MessageManagerDelegate?
    
    
    let baseURL = "http://localhost:8080/api/drift_bottle/v1/"
    
    
    func dropBottle(with message: String) {
        let url = baseURL + "drop"
        print("dropping message:", message)
        self.delegate?.didDropBottle(message: "Message dropped!")
    }
    
    func pickBottle() {
        let url = baseURL + "pickup"
        print("picking up message")
        self.delegate?.didPickBottle(message: "Message picked!")
        
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let message = parseJSON(safeData) {
                        self.delegate?.didPickBottle(message: message)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> String? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(Message.self, from: data)
            return decoded.message
        } catch {
            return nil
        }
    }
    
}
