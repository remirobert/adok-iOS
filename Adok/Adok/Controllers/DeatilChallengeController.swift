//
//  DeatilChallengeController.swift
//  Adok
//
//  Created by Remi Robert on 18/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class DetailChallengeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var challenge: Challenge!
    var photosChallenges: Array<UIImage>!
    let collectionPhotoLayout = UICollectionViewFlowLayout()
    
    lazy var photoCollection: UICollectionView = {
        self.collectionPhotoLayout.minimumLineSpacing = 0
        self.collectionPhotoLayout.minimumInteritemSpacing = 0
        self.collectionPhotoLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width / 4, UIScreen.mainScreen().bounds.size.width / 4)
        let photoCollection = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.height - 64), collectionViewLayout: self.collectionPhotoLayout)
        photoCollection.backgroundColor = UIColor.clearColor()
        photoCollection.delegate = self
        photoCollection.dataSource = self
        return photoCollection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        photoCollection.registerClass(PhotoDetailChallengeCollectionViewCell.self, forCellWithReuseIdentifier: "photoChallengeCell")
        self.view.addSubview(photoCollection)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        return photosChallenges.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: PhotoDetailChallengeCollectionViewCell? = collectionView.dequeueReusableCellWithReuseIdentifier("photoChallengeCell",
            forIndexPath: indexPath) as? PhotoDetailChallengeCollectionViewCell
        cell?.imageView.image = UIImage(named: "img")
        return cell!
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSizeMake(self.view.frame.size.width / 5, self.view.frame.size.width / 5)
//    }
}
