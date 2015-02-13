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

    class func facebookLogin(completionBlockSucess: ()->(), completionBlockFail:(error: NSError!)->()) {
        SimpleAuth.configuration()["facebook"] = [
            "app_id"  : "334710536706235"
        ]
        
        LoginResponse.clear()
        
        SimpleAuth.authorize("facebook", completion: { (response: AnyObject!, error: NSError!) -> Void in
            if (response == nil || error != nil) {
                completionBlockFail(error: error)
                return
            }

            let signupParameters = Signup()
            signupParameters.auth_type = "facebook"
            signupParameters.access_token = ((response as! NSDictionary).objectForKey("credentials")! as! NSDictionary).objectForKey("token")! as! String
            signupParameters.user_id = (response as! NSDictionary).objectForKey("uid")! as! String
            signupParameters.client_id = API_CLIENT_ID
            signupParameters.client_secret = API_CLIENT_SECRET
            signupParameters.device_name = UIDevice.currentDevice().name
            signupParameters.device_id = "43"
            
            Request.signupFacebookRequest(signupParameters, blockSuccess: { (operation, responseToken) -> () in
                NSUserDefaults.standardUserDefaults().removeObjectForKey("signupToken")
                NSUserDefaults.standardUserDefaults().setValue(responseToken, forKey: "signupToken")
                let login = Login()
                login.grant_type = "adok"

                Request.loginRequest(login, token: responseToken, blockSuccess: { (operation, responseLogin) -> () in
                    LoginResponse.clear()
                    responseLogin.save()
                    UserInformation.sharedInstance.informations = responseLogin
                    completionBlockSucess()

                    }, blockFail: { (error) -> () in
                    completionBlockFail(error: error)
                })
                
            }, blockFail: { (error) -> () in
                completionBlockFail(error: error)
            })
        })
    }
}
