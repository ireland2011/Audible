//
//  BaseController.swift
//  Audible
//
//  Created by Genius on 23/4/2017.
//  Copyright © 2017 Genius. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom your view
    }
    
    deinit {
        
        print("deinit: \(type(of: self))")
    }
}
