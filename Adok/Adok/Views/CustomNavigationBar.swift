//
//  CustomNavigationBar.swift
//  Adok
//
//  Created by Remi Robert on 12/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

    override init() {
        super.init()
        println("init navigation Bar")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        println("init navigation bar")
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
