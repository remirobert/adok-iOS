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
        let viewHeader = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        viewHeader.backgroundColor = UIColor.redColor()
        self.tableView.tableHeaderView = viewHeader
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(challengeProfileViewCellIdentifer) as? ChallengeProfileViewCell

        if (cell == nil) {
            cell = ChallengeProfileViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: challengeProfileViewCellIdentifer)
            cell?.initContentCell()
        }
        cell?.imageProfile = UIImage(named: "profile")
        cell?.loginString = "remi robert"
        cell?.contentString = "sauter par dessus une barrière sans tomber."
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let challenge = Challenge()
//        challenge.login = "remi robert"
//        challenge.content = "sauter par dessus une barrière sans tomber."
//        return CGFloat(ChallengeProfileViewCell.calcHeightContent(challenge))
        return 6
    }
    
}
