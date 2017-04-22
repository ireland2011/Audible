//
//  MainNavigationController.swift
//  Audible
//
//  Created by Genius on 22/4/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

import UIKit

class MainNaigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            
            let homeController = HomeController()
            viewControllers = [homeController]
            
        }else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
        
    }
    
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    
    func showLoginController() -> Void {
        
        let loginContoller = LoginController()
        present(loginContoller, animated: true) { 
            // perhaps we'll do something here later
        }
    }
    
}




