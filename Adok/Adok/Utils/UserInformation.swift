//
//  UserInformation.swift
//  Adok
//
//  Created by Remi Robert on 12/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class UserInformation: NSObject {
   
    var informations: LoginResponse!
    
    class var sharedInstance:UserInformation {
        get {
            struct Static {
                static var instance : UserInformation? = nil
            }
            
            if (Static.instance == nil) {
                Static.instance = UserInformation()
            }
            return Static.instance!
        }
    }
    
}
