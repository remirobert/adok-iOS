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
            signupParameters.client_id = "4b3c2399cb206eeb8001a268730e4b7b98efb474e48b72b8d51569a00cd4f8af"
            signupParameters.client_secret = "bd0cd21fb31f0701b634afaeeddcbb91b606b05692feb2fcf52577ec2cff528a"
            signupParameters.device_name = UIDevice.currentDevice().name
            signupParameters.device_id = "43"
            
            Request.signupFacebookRequest(signupParameters, blockSuccess: { (operation, responseToken) -> () in
                println("success : token \(responseToken)")
                
                let login = Login()
                login.grant_type = "adok"
                Request.loginRequest(login, token: responseToken, blockSuccess: { (operation, responseLogin) -> () in
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
