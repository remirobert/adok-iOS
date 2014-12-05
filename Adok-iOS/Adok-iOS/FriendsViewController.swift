//
//  FriendsViewController.swift
//  Adok-iOS
//
//  Created by Remi Robert on 05/12/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, PageViewController {

    var index: NSNumber! = 1
    var titlePageController: String! = "Friends"
    var imagePageController: UIImage! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
