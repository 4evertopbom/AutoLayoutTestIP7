//
//  extensions.swift
//  audiable
//
//  Created by Hoang Anh Tuan on 4/25/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, paddingtop: CGFloat, left: NSLayoutXAxisAnchor?, paddingleft: CGFloat, right: NSLayoutXAxisAnchor?, paddingright: CGFloat, bot: NSLayoutYAxisAnchor?, botpadding: CGFloat, height: CGFloat, width: CGFloat){
    
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingtop).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: paddingright).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingleft).isActive = true
        }
        
        if let bot = bot {
            self.bottomAnchor.constraint(equalTo: bot, constant: botpadding).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        
    }
}
