//
//  MainNavigationController.swift
//  Adok
//
//  Created by Remi Robert on 12/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if let loginResponse = LoginResponse.loadSaved() {
            UserInformation.sharedInstance.informations = loginResponse
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("loginController") as? UIViewController {
                self.presentViewController(loginController, animated: false, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
