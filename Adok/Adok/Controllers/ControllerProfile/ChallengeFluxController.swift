//
//  ChallengeFluxControllerController.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

let challengeProfileViewCellIdentifer = "ChallengeProfileViewCell"

class ChallengeFluxController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(ChallengeProfileViewCell.self, forCellReuseIdentifier: challengeProfileViewCellIdentifer)
        self.view.backgroundColor = UIColor(red:0.83, green:0.84, blue:0.86, alpha:1)
        self.tableView.backgroundColor = UIColor(red:0.83, green:0.84, blue:0.86, alpha:1)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(challengeProfileViewCellIdentifer, forIndexPath: indexPath) as? ChallengeProfileViewCell

        if (cell == nil) {
            cell = ChallengeProfileViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: challengeProfileViewCellIdentifer)
            cell?.initContentCell()
        }
        cell?.imageProfile = UIImage(named: "profile")
        cell?.loginString = "remi robert"
        cell?.contentString = "sauter par dessus une barrière sans tomber."
        return cell!
    }
}
