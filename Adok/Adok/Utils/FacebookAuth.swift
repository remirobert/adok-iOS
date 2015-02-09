//
//  FacebookAuth.swift
//  Adok
//
//  Created by Remi Robert on 08/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit
import Social
import Accounts

class FacebookAuth: NSObject {

    class func facebookLogin() {
        println("facebook login")
        
        SimpleAuth.configuration()["facebook"] = [
            "app_id"  : "334710536706235"
        ]
        
        SimpleAuth.authorize("facebook", completion: { (response: AnyObject!, error: NSError!) -> Void in
            println("response : \(response)")
            println("error :\(error)")
        })
    }
}
