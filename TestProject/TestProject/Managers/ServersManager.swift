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
        guard let url = URL(string: EnvironmentManager.shared.configuration(PlistKey.url)) else { return }
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
                        server.status = self?.getStatus(statusObject) ?? ServerStatus.unknown
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
        case 1: return ServerStatus.active
        case 2: return ServerStatus.running
        case 3: return ServerStatus.slow
        case 4: return ServerStatus.down
        default: return ServerStatus.unknown
        }
    }
}

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
}
