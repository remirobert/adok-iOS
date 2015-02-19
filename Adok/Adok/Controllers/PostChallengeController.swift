//
//  PostChallengeController.swift
//  Adok
//
//  Created by Remi Robert on 16/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class PostChallengeController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var formsCell: Array<UITableViewCell>!
    
    lazy var tableViewFormPost: UITableView = {
        let tableViewFormPost = UITableView(frame: CGRectMake(0, 64,
            UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.height - 64))
        tableViewFormPost.delegate = self
        tableViewFormPost.dataSource = self
        tableViewFormPost.backgroundColor = UIColor.clearColor()
        return tableViewFormPost
    }()
    
    func initCellsForm() {
        formsCell = Array()
        
        let titleChallenge = TitleChallengeForm()
        titleChallenge.initContent()
        formsCell.append(titleChallenge)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        
        initCellsForm()
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))
        self.view.addSubview(navigationBar)
        self.view.addSubview(tableViewFormPost)
        tableViewFormPost.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return formsCell.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("return current cell : \(formsCell[indexPath.row])")        
        return formsCell[indexPath.row]
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 20))
        footerView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (formsCell[indexPath.section] as! TitleChallengeForm).sizeHeight
    }
}
