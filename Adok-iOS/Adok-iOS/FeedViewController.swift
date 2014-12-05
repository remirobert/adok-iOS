//
//  FeedViewController.swift
//  Adok-iOS
//
//  Created by Remi Robert on 05/12/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, PageViewController, UITableViewDelegate, UITableViewDataSource {

    var index: NSNumber! = 1
    var titlePageController: String! = "Challenges"
    var imagePageController: UIImage! = nil
    
    var feedTableView: UITableView!
    var defaultCell: UITableViewCell!
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("default") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "default")
            
            var subView = UIView(frame: CGRectMake(10, 5, self.view.frame.size.width - 20, 190))
            subView.backgroundColor = UIColor.whiteColor()
            subView.layer.shadowColor = UIColor.blackColor().CGColor
            subView.layer.shadowOffset = CGSizeMake(0, 0)
            subView.layer.shadowRadius = 4
            subView.layer.shadowOpacity = 0.2
            subView.layer.masksToBounds = false
            
            cell!.contentView.addSubview(subView)

        }
        return cell!
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedTableView = UITableView(frame: self.view.frame)
        self.feedTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.view.addSubview(self.feedTableView)
        
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
