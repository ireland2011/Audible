//
//  MainController.swift
//  Audible
//
//  Created by Genius on 23/4/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

import UIKit

class HomeController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "home"))
        imageView.frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(imageView)
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target:self, action: #selector(signOut))
        
    }
    
    
    func signOut() -> Void {
        
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        
    }
}
