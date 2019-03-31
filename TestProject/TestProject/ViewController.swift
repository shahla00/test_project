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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "ServerCell", bundle: nil), forCellReuseIdentifier: "ServerCell")
        
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
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServerCell", for: indexPath) as? ServerCell else { return UITableViewCell() }
        cell.server = servers[indexPath.row]
        return cell
    }
}

