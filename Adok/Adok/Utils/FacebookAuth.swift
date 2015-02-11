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
            NSLog("\(response)")
            if (response == nil || error != nil) {
                println("handle error signup : \(error)")
                return
            }
            let token = ((response as NSDictionary).objectForKey("credentials")! as NSDictionary).objectForKey("token")! as String
            let uid = (response as NSDictionary).objectForKey("uid")! as String
            
            println("user id : \(uid)")
            
            let parameters = ["auth_type":"facebook", "access_token":token, "user_id": uid, "client_id":"4b3c2399cb206eeb8001a268730e4b7b98efb474e48b72b8d51569a00cd4f8af", "client_secret":"bd0cd21fb31f0701b634afaeeddcbb91b606b05692feb2fcf52577ec2cff528a", "device_name":UIDevice.currentDevice().name, "device_id":"43"]
            
            
            let manager = AFHTTPRequestOperationManager()
            
            manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
            manager.POST("http://192.168.1.32:8080/signup", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                
                if let token = (response as NSDictionary).objectForKey("access_token") as? String {
                    // handle token here
                    NSLog("date : \(token)")
                }
                
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("response : \(error)")
            })
        })
    }
}
