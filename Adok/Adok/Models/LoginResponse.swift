//
//  LoginResponse.swift
//  Adok
//
//  Created by Remi Robert on 11/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class LoginResponse: NSObject, NSCoding {
    var access_token: String!
    var refresh_token: String!
    var expires_in: NSNumber!
    var token_type: String!
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.access_token, forKey: "access_token")
        aCoder.encodeObject(self.refresh_token, forKey: "refresh_token")
        aCoder.encodeObject(self.expires_in, forKey: "expires_in")
        aCoder.encodeObject(self.token_type, forKey: "token_types")
    }
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.access_token  = aDecoder.decodeObjectForKey("access_token") as? String
        self.refresh_token  = aDecoder.decodeObjectForKey("refresh_token") as? String
        self.expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        self.token_type  = aDecoder.decodeObjectForKey("token_type") as? String
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "loginResponse")
    }
    
    class func loadSaved() -> LoginResponse? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("loginResponse") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? LoginResponse
        }
        return nil
    }
    
    class func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("loginResponse")
    }
}
