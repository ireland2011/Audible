//
//  LoginCell.swift
//  Audible
//
//  Created by Genius on 19/4/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

import UIKit
import SnapKit

class LoginCell: UICollectionViewCell {
    
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        return imageView
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter email"
        textField.keyboardType = .emailAddress
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    
    let passwordTextField: LeftPaddedTextField = {
        let textFiled = LeftPaddedTextField()
        textFiled.placeholder = "Enter password"
        textFiled.isSecureTextEntry = true
        textFiled.layer.borderColor = UIColor.lightGray.cgColor
        textFiled.layer.borderWidth = 1
        return textFiled
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Login in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
            make.size.equalTo(CGSize(width: 160, height: 160))
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 10, height: bounds.height)
    }
}




