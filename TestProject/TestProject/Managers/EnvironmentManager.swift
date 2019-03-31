//
//  Environment.swift
//  TestProject
//
//  Created by Shahla Almasri Hafez on 3/31/19.
//  Copyright © 2019 Shahla Almasri Hafez. All rights reserved.
//

import Foundation

public enum PlistKey {
    case url
    
    var value: String {
        if self == .url {
            return "url"
        }
        return ""
    }
}

public struct EnvironmentManager {
    private init() { }
    static let shared = EnvironmentManager()
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            } else {
                fatalError("Plist file not found")
            }
        }
    }
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .url:
            return (infoDict[PlistKey.url.value] as? String)?
                .replacingOccurrences(of: "\\", with: "") ?? ""
        }
    }
}
