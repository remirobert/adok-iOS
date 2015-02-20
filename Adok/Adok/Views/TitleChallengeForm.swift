//
//  TitleChallengeForm.swift
//  Adok
//
//  Created by Remi Robert on 19/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class TitleChallengeForm: UITableViewCell {
    lazy var title: UILabel = {
        let title = UILabel(frame: CGRectMake(0, 5, UIScreen.mainScreen().bounds.size.width, 20))
        title.textAlignment = NSTextAlignment.Center
        title.font = UIFont.boldSystemFontOfSize(16)
        title.textColor = UIColor(red:0.13, green:0.24, blue:0.57, alpha:1) 
        return title
    }()
    
    lazy var textViewContent: UITextView = {
        let textViewContent = UITextView(frame: CGRectMake(10, 40, UIScreen.mainScreen().bounds.size.width - 20, 40))
        textViewContent.scrollEnabled = false
        textViewContent.backgroundColor = UIColor.clearColor()
        textViewContent.font = UIFont.systemFontOfSize(15)
        textViewContent.tag = 1
        return textViewContent
    }()
        
    var sizeHeight: CGFloat {
        get {
            return 40 + textViewContent.frame.size.height
        }
        set {
            
        }
    }

    func initContent() {
        self.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(title)
        title.text = "Title (required)"
        self.contentView.addSubview(textViewContent)
    }
 }
