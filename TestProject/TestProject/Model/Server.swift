//
//  Server.swift
//  TestProject
//
//  Created by Shahla Almasri Hafez on 3/30/19.
//  Copyright © 2019 Shahla Almasri Hafez. All rights reserved.
//

import Foundation

enum ServerStatus: Int {
    case unknown = 0
    case active
    case running
    case slow
    case down
}

class Server {
    var country = "Brasil"
    var serverName: String?
    var ipAddress: String?
    var devideIP: String?
    var status = ServerStatus.unknown
    var statusValue: String?
}
