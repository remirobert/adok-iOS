//
//  VoteController.swift
//  Hadok
//
//  Created by Remi Robert on 10/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

class VoteController: UITableViewController, PageController {
    
    var titlePageController: String?
    var imagePageController: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
