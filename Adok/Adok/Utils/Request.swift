//
//  Request.swift
//  Adok
//
//  Created by Remi Robert on 11/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class Request: NSObject {
    
    private class func meRequest(token: String,
        blockSuccess completion:(operation: AFHTTPRequestOperation!, responseMe: Me!)->(),
        blockFail completionFail:(error: NSError!)->()) {
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
            manager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            manager.GET("http://127.0.0.1:8080/me", parameters: nil,
                success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    println("response : \(response)")
                    if let meResponse: AnyObject = SerializeObject.convertJsonToObject(response as! NSDictionary, classObjectResponse: "Me") {
                        completion(operation: operation, responseMe: meResponse as! Me)
                    }
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    completionFail(error: error)
            })
    }
    
    private class func getNewToken(completion:(newToken: String!)->(),
        completionFail:(error: NSError!)->()) {
            if let token = NSUserDefaults.standardUserDefaults().stringForKey("signupToken") {
                let loginParameter = Login()
                loginParameter.grant_type = "adok"
                Request.loginRequest(loginParameter, token: token, blockSuccess: { (operation, responseLogin) -> () in
                    responseLogin.save()
                    UserInformation.sharedInstance.informations = responseLogin
                    completion(newToken: responseLogin.access_token)
                }, blockFail: { (error) -> () in
                    completionFail(error: error)
                })
            }
            completionFail(error: nil)
    }
    
    class func launchMeRequest(token: String,
        blockSuccess completion:(operation: AFHTTPRequestOperation!, responseMe: Me!)->(),
        blockFail completionFail:(error: NSError!)->()) {
            meRequest(token, blockSuccess: { (operation, responseMe) -> () in
                completion(operation: operation, responseMe: responseMe)
            }) { (error) -> () in
                self.getNewToken({ (newToken) -> () in
                    self.launchMeRequest(newToken, blockSuccess: completion, blockFail: completionFail)
                }, completionFail: { (error) -> () in
                    completionFail(error: error)
                })
            }
    }
    
    class func loginRequest(parameters: Login!, token: String,
        blockSuccess completion:(operation: AFHTTPRequestOperation!, responseLogin: LoginResponse!)->(),
        blockFail completionFail:(error: NSError!)->()) {
            if let jsonDictionary = SerializeObject.convertObjectToJson(parameters) {
                let manager = AFHTTPRequestOperationManager()
                manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
                manager.requestSerializer.setValue("Adok \(token)", forHTTPHeaderField: "Authorization")
                manager.POST("http://127.0.0.1:8080/login", parameters: jsonDictionary,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        if let loginResponse: AnyObject = SerializeObject.convertJsonToObject(response as! NSDictionary, classObjectResponse: "LoginResponse") {
                            completion(operation: operation, responseLogin: loginResponse as! LoginResponse)
                        }
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                       
                        completionFail(error: error)
                })
            }
            else {
                completionFail(error: nil)
            }
    }
    
    class func signupFacebookRequest(parameters: Signup!,
        blockSuccess completion:(operation: AFHTTPRequestOperation!, responseToken: String!)->(),
        blockFail completionFail:(error: NSError!)->()) {
            if let jsonDictionary = SerializeObject.convertObjectToJson(parameters) {
                let manager = AFHTTPRequestOperationManager()
                manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
                manager.POST("http://127.0.0.1:8080/signup", parameters: jsonDictionary,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    if let token = (response as! NSDictionary).objectForKey("access_token") as? String {
                        Request.meRequest(token, blockSuccess: { (operation, responseMe) -> () in
                            completion(operation: operation, responseToken: token)
                            Me.clear()
                            responseMe.save()
                        }, blockFail: { (error) -> () in
                            completion(operation: operation, responseToken: token)
                        })
                    }
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        completionFail(error: error)
                })
            }
            else {
                completionFail(error: nil)
            }
    }
    
}
