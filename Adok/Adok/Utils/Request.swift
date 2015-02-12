//
//  Request.swift
//  Adok
//
//  Created by Remi Robert on 11/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class Request: NSObject {
    
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
                        completion(operation: operation, responseToken: token)
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
