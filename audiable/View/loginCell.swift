//
//  loginCell.swift
//  audiable
//
//  Created by Hoang Anh Tuan on 4/26/19.
//  Copyright © 2019 Hoang Anh Tuan. All rights reserved.
//

import Foundation
import UIKit

class loginCell: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "logo")
        return iv
    }()
    
    let emailTextfield: LeftPaddedTextField = {
        let tf = LeftPaddedTextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.placeholder = "Enter email"
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let passwordTextfield: LeftPaddedTextField = {
        let tf = LeftPaddedTextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.placeholder = "Enter password"
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var signInButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.backgroundColor = .orange
        bt.setTitle("Log in", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return bt
    }()
    
    weak var delegate: LoginControllerDelegate?
    
    @objc func handleLogin() {
        delegate?.didLoggedIn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView)
        addSubview(emailTextfield)
        addSubview(passwordTextfield)
        addSubview(signInButton)
        
        logoImageView.anchor(top: safeAreaLayoutGuide.topAnchor, paddingtop: frame.height * 0.15, left: nil, paddingleft: 0, right: nil, paddingright: 0, bot: nil, botpadding: 0, height: 160, width: 160)
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        emailTextfield.anchor(top: logoImageView.bottomAnchor, paddingtop: 8, left: leftAnchor, paddingleft: 40, right: rightAnchor, paddingright: -40, bot: nil, botpadding: 0, height: 50, width: 0)
        passwordTextfield.anchor(top: emailTextfield.bottomAnchor, paddingtop: 16, left: leftAnchor, paddingleft: 40, right: rightAnchor, paddingright: -40, bot: nil, botpadding: 0, height: 50, width: 0)
        signInButton.anchor(top: passwordTextfield.bottomAnchor, paddingtop: 16, left: leftAnchor, paddingleft: 40, right: rightAnchor, paddingright: -40, bot: nil, botpadding: 0, height: 50, width: 0)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}
