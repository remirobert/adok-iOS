//
//  ChallengeContent.swift
//  HadokNewAnimation
//
//  Created by Remi Robert on 28/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

class ChallengeContent: NSObject {
    var imageProfile: String
    var textChallenge: String
    var titleChallenge: String
    var heightContent: CGFloat
    
    init(imageProfile: String, textChallenge: String, titleChallenge: String) {
        self.imageProfile = imageProfile
        self.textChallenge = textChallenge
        self.titleChallenge = titleChallenge
        self.heightContent = 0
        super.init()
    }
    
}
