//
//  Page.swift
//  audiable
//
//  Created by Hoang Anh Tuan on 4/25/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

struct Page {
    let title: String
    let message: String
    let imageName: String
    
    init(title: String, message: String, imageName: String) {
        self.title = title
        self.message = message
        self.imageName = imageName
    }
}
