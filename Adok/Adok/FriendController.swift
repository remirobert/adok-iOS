//
//  FriendController.swift
//  HadokNewAnimation
//
//  Created by Remi Robert on 15/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

class FriendController: UIViewController, PageController, UICollectionViewDataSource {

    var titlePageController: String?
    var imagePageController: UIImage?
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let widthCell = CGFloat((self.view.frame.size.width - 80.0) / 3.0)
        
        layout.itemSize = CGSizeMake(widthCell, widthCell + 30)
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.height - 64), collectionViewLayout: layout)
        self.collectionView?.registerClass(FriendCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.dataSource = self
        
        self.collectionView?.backgroundColor = UIColor.clearColor()
        
        self.collectionView?.showsVerticalScrollIndicator = false;
        
        self.view.addSubview(self.collectionView!)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: FriendCollectionViewCell? = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? FriendCollectionViewCell
        
        return cell! as UICollectionViewCell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
