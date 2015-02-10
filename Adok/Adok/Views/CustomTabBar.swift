//
//  CustomTabBar.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBar {

    override func awakeFromNib() {
        let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark)) as UIVisualEffectView
        visualEffect.frame = self.frame
        self.addSubview(visualEffect)
        ///self.insertSubview(visualEffect, belowSubview: self)
    }
}
