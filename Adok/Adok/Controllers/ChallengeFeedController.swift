//
//  ChallengeFeedController.swift
//  Adok
//
//  Created by Remi Robert on 09/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

let challengeCellIdentifier = "ChallengeFeedTableViewCell"

class ChallengeFeedController: UITableViewController {

    var challenge = Challenge()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.83, green:0.84, blue:0.86, alpha:1)
        challenge.content = "salut"
        challenge.login = "salut "
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor(red:0.83, green:0.84, blue:0.86, alpha:1)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
        self.tableView.registerClass(ChallengeFeedTableViewCell.self, forCellReuseIdentifier: challengeCellIdentifier)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(ChallengeFeedTableViewCell.calcHeightContent(challenge))
        //return 140
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ChallengeFeedTableViewCell? = tableView.dequeueReusableCellWithIdentifier("challengeCell") as? ChallengeFeedTableViewCell
        if (cell == nil) {
            cell = ChallengeFeedTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: challengeCellIdentifier)
            cell?.initContentCell()
        }
        cell?.loginContent = challenge.login
        cell?.textContent = challenge.content
        cell?.imageContent = UIImage(named: "img")
        return cell!
    }

}
