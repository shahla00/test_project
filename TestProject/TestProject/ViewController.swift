//
//  ViewController.swift
//  TestProject
//
//  Created by Shahla Almasri Hafez on 3/30/19.
//  Copyright © 2019 Shahla Almasri Hafez. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    var servers = [Server]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.table.reloadData()
            }
        }
    }
    
    var activeServers: [Server] {
        return servers.filter { $0.status == .active }
    }
    
    var inactiveServers: [Server] {
        return servers.filter { $0.status != .active }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "ServerCell", bundle: nil), forCellReuseIdentifier: "ServerCell")
        table.register(UINib(nibName: "SectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeader")
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
        ServersManager.shared.fetchData();
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        if let data = notification.object as? [Server] {
            servers = data
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return -1
        }
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return inactiveServers.count
        }
        
        return activeServers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServerCell", for: indexPath) as? ServerCell else { return UITableViewCell() }
        let server = indexPath.section == 0 ? inactiveServers[indexPath.row] : activeServers[indexPath.row]
        cell.server = server
        return cell
    }
}

