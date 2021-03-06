//
//  MainNavigationController.swift
//  Adok
//
//  Created by Remi Robert on 12/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class MainNavigationController: UITabBarController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        println("check login displayed")
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
    
    func load() {
        ProgressView.displayProgressView(self.view, textContent: "Loading")
    }
    
    func hideLoad() {
        ProgressView.hideProgressView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "load", name: "load", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideLoad", name: "hideLoad", object: nil)
        
        let profileItem = self.tabBar.items?[0] as? UITabBarItem
        profileItem?.title = "Me"
        profileItem?.selectedImage = UIImage(named: "profileMe")

        let feedItem = self.tabBar.items?[1] as? UITabBarItem
        feedItem?.title = "Challenges"
        feedItem?.selectedImage = UIImage(named: "feed")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
