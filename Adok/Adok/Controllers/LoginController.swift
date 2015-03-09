//
//  LoginController.swift
//  Adok
//
//  Created by Remi Robert on 08/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    var isConnected = false
    
    @IBAction func facebookLogin(sender: AnyObject) {
        if isConnected == true {
            return
        }
        isConnected = true
        FacebookAuth.facebookLogin({ () -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
            self.isConnected = false
        }, completionBlockFail: { (error) -> () in
            self.isConnected = false
            println("error : \(error)")
            AlertView.displayAlertView(self.view, title: "Error lors de la connection", message: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
