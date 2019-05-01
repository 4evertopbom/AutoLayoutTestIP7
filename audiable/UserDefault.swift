//
//  UserDefault.swift
//  audiable
//
//  Created by Hoang Anh Tuan on 4/27/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    
    enum UserDefaultKeys: String {
        case isLoggedIn
    }
    
    func changeLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }
}

