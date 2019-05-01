//
//  HomeController.swift
//  audiable
//
//  Created by Hoang Anh Tuan on 4/27/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class HomeController: UIViewController {
    
    let homeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "home")
        return iv
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogout))
        
        view.addSubview(homeImageView)
        
        homeImageView.anchor(top: view.topAnchor, paddingtop: 0, left: view.leftAnchor, paddingleft: 0, right: view.rightAnchor, paddingright: 0, bot: view.bottomAnchor, botpadding: 0, height: 0, width: 0)
    }
    
    @objc func handleLogout() {
        UserDefaults.standard.changeLoggedIn(value: false)
        
        let loginController = LoginController()
        self.present(loginController, animated: true, completion: nil)
    }
}
