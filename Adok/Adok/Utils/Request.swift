//
//  Request.swift
//  Adok
//
//  Created by Remi Robert on 11/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class Request: NSObject {
    
    // MARK: new Token request
    
    private class func loginRequestNewtoken(header: String,
        blockSuccess completion:()->(),
        blockFail completionFail:(error: NSError!)->()) {
        let manager = AFHTTPRequestOperationManager()
            
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
        manager.requestSerializer.setValue("Basic \(header)", forHTTPHeaderField: "Authorization")
        let parameter = ["grant_type":"refresh_token", "refresh_token":UserInformation.sharedInstance.informations.refresh_token]
            
        manager.POST("\(BASE_URL)login", parameters: parameter,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                if let loginResponse: LoginResponse! = SerializeObject.convertJsonToObject(response as! NSDictionary, classObjectResponse: "LoginResponse") as? LoginResponse {
                    LoginResponse.clear()
                    loginResponse.save()
                    UserInformation.sharedInstance.informations = loginResponse
                    completion()
                }
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                completionFail(error: error)
        })
    }
    
    private class func getNewToken(completion:(newToken: String!)->(),
        completionFail:(error: NSError!)->()) {
            let loginParameter = Login()
            loginParameter.grant_type = "adok"

            let headerData: NSData = "\(API_CLIENT_ID):\(API_CLIENT_SECRET)".dataUsingEncoding(NSUTF8StringEncoding)!
            let headerString = headerData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))

            Request.loginRequestNewtoken(headerString as String, blockSuccess: { () -> () in
                completion(newToken: UserInformation.sharedInstance.informations.access_token)
            }) { (error) -> () in
                println("error refresh token 2 : \(error)")
            }
    }
    
    // MARK: request Event
    
    private class func feedEventRequest(token: String, parameters: Feed,
        blockSuccess completion:(operation: AFHTTPRequestOperation!, responseFeed: [Challenge]!)->(),
        blockFail completionFail:(error: NSError!)->()) {
        
            if let jsonDictionary = SerializeObject.convertObjectToJson(parameters) {
            
                let manager = AFHTTPRequestOperationManager()
                manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
                manager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                manager.GET("\(BASE_URL)events", parameters: parameters,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        var feeds: Array<Challenge> = Array()
                        for currentEvent in (response.objectForKey("items") as! NSArray) {
                            if let event = SerializeObject.convertJsonToObject(currentEvent as! NSDictionary, classObjectResponse: "Challenge") as? Challenge {
                                event.user = User()
                                event.user._id = (currentEvent.objectForKey("acc") as! NSDictionary).objectForKey("_id") as! String
                                event.user.full = (currentEvent.objectForKey("acc") as! NSDictionary).objectForKey("name") as! String
                                feeds.append(event)
                            }
                        }
                        completion(operation: operation, responseFeed: feeds)
                        
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("erro : \(error)")
                        completionFail(error: error)
                })
            }
            else {
                completionFail(error: nil)
            }
    }
    
    class func launchFeedEventRequest(token: String, parameters: Feed,
        blockSuccess completion:(operation: AFHTTPRequestOperation!, responseFeed: [Challenge]!)->(),
        blockFail completionFail:(error: NSError!)->()) {
        
        feedEventRequest(token, parameters: parameters, blockSuccess: { (operation, responseFeed) -> () in
            completion(operation: operation, responseFeed: responseFeed)
        }) { (error) -> () in
            self.getNewToken({ (newToken) -> () in
                self.feedEventRequest(token, parameters: parameters, blockSuccess: { (operation, responseFeed) -> () in
                    completion(operation: operation, responseFeed: responseFeed)
                }, blockFail: { (error) -> () in
                    completionFail(error: error)
                })
            }, completionFail: { (error) -> () in
                completionFail(error: error)
            })
        }
    }
    // MARK: request Me

    private class func meRequest(token: String,
        blockSuccess completion:(operation: AFHTTPRequestOperation!, responseMe: Me!)->(),
        blockFail completionFail:(error: NSError!)->()) {

            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
            manager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            manager.GET("\(BASE_URL)me", parameters: nil,
                success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    if let meResponse: AnyObject = SerializeObject.convertJsonToObject(response as! NSDictionary, classObjectResponse: "Me") {
                        completion(operation: operation, responseMe: meResponse as! Me)
                    }
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("erro : \(error)")
                    completionFail(error: error)
            })
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
                    println("get new token fail")
                    completionFail(error: error)
                })
            }
    }
    
    // MARK: request login
    
    class func loginRequest(parameters: Login!, token: String,
        blockSuccess completion:(operation: AFHTTPRequestOperation!, responseLogin: LoginResponse!)->(),
        blockFail completionFail:(error: NSError!)->()) {
            if let jsonDictionary = SerializeObject.convertObjectToJson(parameters) {
     
                let manager = AFHTTPRequestOperationManager()
                manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
                manager.requestSerializer.setValue("Adok \(token)", forHTTPHeaderField: "Authorization")
                
                manager.POST("\(BASE_URL)login", parameters: jsonDictionary,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        if let loginResponse: AnyObject = SerializeObject.convertJsonToObject(response as! NSDictionary, classObjectResponse: "LoginResponse") {
                            LoginResponse.clear()
                            loginResponse.save()
                            UserInformation.sharedInstance.informations = loginResponse as! LoginResponse
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
    
    // MARK: request Signup
    
    class func signupFacebookRequest(parameters: Signup!,
        blockSuccess completion:(operation: AFHTTPRequestOperation!, responseToken: String!)->(),
        blockFail completionFail:(error: NSError!)->()) {
            if let jsonDictionary = SerializeObject.convertObjectToJson(parameters) {

                let manager = AFHTTPRequestOperationManager()
                manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
                
                manager.POST("\(BASE_URL)signup", parameters: jsonDictionary,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in

                        if let token = (response as! NSDictionary).objectForKey("access_token") as? String {
                            completion(operation: operation, responseToken: token)
                        }
                        else {
                            completionFail(error: nil)
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
