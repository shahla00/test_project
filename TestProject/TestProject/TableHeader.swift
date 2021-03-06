//
//  TableHeader.swift
//  TestProject
//
//  Created by Shahla Almasri Hafez on 3/31/19.
//  Copyright © 2019 Shahla Almasri Hafez. All rights reserved.
//

import UIKit

class TableHeader: UIView {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var allContainer: UIView!
    @IBOutlet weak var activeContainer: UIView!
    @IBOutlet weak var downContainer: UIView!
    @IBOutlet weak var allLocationsContainer: UIView!
    @IBOutlet weak var allLocationsButton: UIButton!
    @IBOutlet weak var serversCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchBar.layer.cornerRadius = 50
        allContainer.layer.cornerRadius = 20
        serversCount.layer.cornerRadius = 10
        
        activeContainer.layer.borderWidth = 1
        activeContainer.layer.borderColor = UIColor.lightGray.cgColor
        activeContainer.layer.cornerRadius = 20
        
        downContainer.layer.borderWidth = 1
        downContainer.layer.borderColor = UIColor.lightGray.cgColor
        downContainer.layer.cornerRadius = 20
        
        allLocationsContainer.layer.borderWidth = 1
        allLocationsContainer.layer.borderColor = UIColor.lightGray.cgColor
        allLocationsContainer.layer.cornerRadius = 20
        allLocationsButton.imageView?.contentMode = .scaleAspectFit
    }
}
