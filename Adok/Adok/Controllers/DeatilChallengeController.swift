//
//  DeatilChallengeController.swift
//  Adok
//
//  Created by Remi Robert on 18/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class DetailChallengeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var refreshControl: UIRefreshControl!
    var challenge: Challenge!
    var photosChallenges: Array<UIImage>!
    let collectionPhotoLayout = UICollectionViewFlowLayout()
    
    lazy var photoCollection: UICollectionView = {
        self.collectionPhotoLayout.minimumLineSpacing = 0
        self.collectionPhotoLayout.minimumInteritemSpacing = 0
        self.collectionPhotoLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 200)
        self.collectionPhotoLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width / 4, UIScreen.mainScreen().bounds.size.width / 4)
        let photoCollection = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.height - 64), collectionViewLayout: self.collectionPhotoLayout)

        photoCollection.registerClass(PhotoDetailChallengeCollectionViewCell.self, forCellWithReuseIdentifier: "photoChallengeCell")
        photoCollection.registerClass(HeaderDetailChallengeView.self,
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerChallenge")
        
        photoCollection.backgroundColor = UIColor.clearColor()
        photoCollection.delegate = self
        photoCollection.dataSource = self
        return photoCollection
    }()
    
    func refreshContentDetail() {
        refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.addSubview(photoCollection)
        
        refreshControl = UIRefreshControl()
        refreshControl?.layer.masksToBounds = true
        refreshControl?.tintColor = UIColor.whiteColor()
        refreshControl?.backgroundColor = UIColor(red:0.18, green:0.27, blue:0.55, alpha:1)
        refreshControl?.addTarget(self, action: "refreshContentDetail", forControlEvents: UIControlEvents.ValueChanged)
        photoCollection.addSubview(self.refreshControl!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
        return photosChallenges.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: PhotoDetailChallengeCollectionViewCell? = collectionView.dequeueReusableCellWithReuseIdentifier("photoChallengeCell",
            forIndexPath: indexPath) as? PhotoDetailChallengeCollectionViewCell
        cell?.imageView.image = UIImage(named: "img")
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            
            var headerView: HeaderDetailChallengeView?
            if (kind == UICollectionElementKindSectionHeader) {
                headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader,
                    withReuseIdentifier: "headerChallenge", forIndexPath: indexPath) as? HeaderDetailChallengeView
                headerView?.initContent(challenge)
                self.collectionPhotoLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, headerView!.heightContent!)
            }
            return headerView!
    }
}
