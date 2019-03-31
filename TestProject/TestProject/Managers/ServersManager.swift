//
//  ServersManager.swift
//  TestProject
//
//  Created by Shahla Almasri Hafez on 3/30/19.
//  Copyright © 2019 Shahla Almasri Hafez. All rights reserved.
//

import Foundation

class ServersManager {
    private init() { }
    static let shared = ServersManager()
    
    ///
    /// Fetches the servers data from the server
    ///
    func fetchData() {
        guard let url = URL(string: "http://www.mocky.io/v2/5c5c46f13900005a18e05b90") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let dataResponse = data, error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as? [String: Any]
                if let serversArray = jsonResponse?["content"] as? [[String: Any]] {
                    var servers = [Server]()
                    for serverObject in serversArray {
                        let server = Server()
                        server.serverName = serverObject["name"] as? String
                        server.ipAddress = serverObject["ipAddress"] as? String
                        server.devideIP = serverObject["ipSubnetMask"] as? String
                        let statusObject = serverObject["status"] as? [String: Any]
                        server.status = self?.getStatus(statusObject) ?? ServerStatus.Unknown
                        server.statusValue = statusObject?["statusValue"] as? String
                        servers.append(server)
                    }
                    NotificationCenter.default.post(name: .didReceiveData, object: servers)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    private func getStatus(_ statusObject: [String: Any]?) -> ServerStatus {
        let statusCode = statusObject?["id"] as? Int
        switch statusCode {
        case 1: return ServerStatus.Active
        case 2: return ServerStatus.Running
        case 3: return ServerStatus.Slow
        case 4: return ServerStatus.Down
        default: return ServerStatus.Unknown
        }
    }
}

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
}
