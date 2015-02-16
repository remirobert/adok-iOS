//
//  ButtonAdd.swift
//  Adok
//
//  Created by Remi Robert on 16/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ButtonAdd: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = frame.size.width / 2
        self.backgroundColor = UIColor(red:0.13, green:0.24, blue:0.57, alpha:1)
        self.layer.borderColor = UIColor(red:0.18, green:0.27, blue:0.55, alpha:1).CGColor
        self.layer.borderWidth = 5
        self.setImage(UIImage(named: "add"), forState: UIControlState.Normal)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
