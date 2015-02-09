//
//  ChallengeFeedController.swift
//  Adok
//
//  Created by Remi Robert on 09/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ChallengeFeedController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("challengeCell") as ChallengeFeedTableViewCell

        cell.loginLabel.text = "remi robert"
        cell.timeLabel.text = "il a 1 heure"
        cell.contentLabel.text = "blabla"
        return cell
    }

}
