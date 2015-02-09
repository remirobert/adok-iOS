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
        SimpleAuth.configuration()["facebook"] = [
            "app_id"  : "334710536706235"
        ]
        
        SimpleAuth.authorize("facebook", completion: { (response: AnyObject!, error: NSError!) -> Void in
            if (response == nil || error == nil) {
                println("handle error signup : \(error)")
                return
            }
            let token = ((response as NSDictionary).objectForKey("credentials")! as NSDictionary).objectForKey("token")! as String
            let uid = (response as NSDictionary).objectForKey("uid")! as String
            
            let parameters = ["auth_type":"facebook", "access_token":token, "userId": uid, "client_id":"334710536706235", "client_secret":"2daff7d05af78c778fb550bd826f2d35", "device":UIDevice.currentDevice().name]
            
            let manager = AFHTTPRequestOperationManager()
            manager.POST("\(BASE_URL)signup", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                
                println("response : \(response)")
                
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("response : \(error)")
            })
            
        })
    }
}
