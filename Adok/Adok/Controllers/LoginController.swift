//
//  LoginController.swift
//  Adok
//
//  Created by Remi Robert on 08/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBAction func facebookLogin(sender: AnyObject) {
        FacebookAuth.facebookLogin({ () -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
        }, completionBlockFail: { (error) -> () in
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
