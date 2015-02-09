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

//let apiKey = "334710536706235"
//let appSecret = "2daff7d05af78c778fb550bd826f2d35"

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
        
//        if (FBSession.activeSession().state == FBSessionState.Open ||
//            FBSession.activeSession().state == FBSessionState.OpenTokenExtended) {
//                println("connection open")
//                performFacebookLogin()
//        }
//        else {
//            println("connection ok")
//            FBSession.openActiveSessionWithReadPermissions(["public_profile", "email"], allowLoginUI: true, completionHandler: { (session: FBSession!,
//                state: FBSessionState, error: NSError!) -> Void in
//                println(session)
//                println(state)
//                println(error)
//            })
//        }
    }
    
    private class func performFacebookLogin() {
        println("perform login")
//        let accountStore = ACAccountStore()
//        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
//        
//        let options = NSDictionary(objects: ["334710536706235", ["email"]], forKeys: [ACFacebookAppIdKey, ACFacebookPermissionsKey])
//        accountStore.requestAccessToAccountsWithType(accountType, options: options) { (granted: Bool, error: NSError!) -> Void in
//            println("ERROR : \(error)")
//            println("GRANTED: \(granted)")
//        }
    }
}
