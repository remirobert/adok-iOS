//
//  BadgeController.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

let badgeCellIdentifier = "badgeCellIdentifier"

class BadgeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var collectionBadge: UICollectionView! = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionBadge = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionBadge.delegate = self
        collectionBadge.dataSource = self
        collectionBadge.backgroundColor = UIColor(red:0.83, green:0.84, blue:0.86, alpha:1)
        collectionBadge.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: badgeCellIdentifier)
        return collectionBadge
    }()
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.view.frame.width / 4, self.view.frame.width / 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.83, green:0.84, blue:0.86, alpha:1)
        self.view.addSubview(collectionBadge)
        collectionBadge.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 47   
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(badgeCellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        return cell
    }
    
}
