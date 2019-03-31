//
//  ServerCell.swift
//  TestProject
//
//  Created by Shahla Almasri Hafez on 3/30/19.
//  Copyright © 2019 Shahla Almasri Hafez. All rights reserved.
//

import UIKit

class ServerCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var serverName: UILabel!
    @IBOutlet weak var ipAddress: UILabel!
    @IBOutlet weak var deviceIp: UILabel!
    @IBOutlet weak var cpuStatusContainer: UIView!
    @IBOutlet weak var cpuStatus: UILabel!
    @IBOutlet weak var status: UIView!
    @IBOutlet weak var statusInnerCircle: UIView!
    
    var server: Server? {
        didSet {
            guard let server = server else { return }
            country.text = server.country
            serverName.text = server.serverName
            ipAddress.text = server.ipAddress
            deviceIp.text = server.devideIP
            cpuStatus.text = server.statusValue
            
            switch server.status {
            case .active: status.backgroundColor = .green
            case .unknown: status.backgroundColor = .lightGray
            case .running: status.backgroundColor = .orange
            case .slow: status.backgroundColor = .yellow
            case .down: status.backgroundColor = .red
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        icon.layer.cornerRadius = icon.frame.width / 2
        cpuStatusContainer.layer.cornerRadius = 20
        status.layer.cornerRadius = status.frame.width / 2
        statusInnerCircle.layer.cornerRadius = statusInnerCircle.frame.width / 2
    }
}
