//
//  Me.swift
//  Adok
//
//  Created by Remi Robert on 12/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class Me: NSObject, NSCoding {
    var _id: String!
    var email: String!
    var first_name: String!
    var last_name: String!
    var name: String!
    var picture: String!
    var provider: String!
    var verified: NSNumber!
    var images: NSNumber!
    var friends: NSNumber!
    var badges: NSNumber!
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.email, forKey: "email")
        aCoder.encodeObject(self.first_name, forKey: "first_name")
        aCoder.encodeObject(self.last_name, forKey: "last_name")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.picture, forKey: "picture")
        aCoder.encodeObject(self.provider, forKey: "provider")
        aCoder.encodeObject(self.verified, forKey: "verified")
        aCoder.encodeObject(self.images, forKey: "images")
        aCoder.encodeObject(self.friends, forKey: "friends")
        aCoder.encodeObject(self.badges, forKey: "badges")
    }
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.email  = aDecoder.decodeObjectForKey("email") as? String
        self.first_name  = aDecoder.decodeObjectForKey("first_name") as? String
        self.last_name = aDecoder.decodeObjectForKey("last_name") as? String
        self.name  = aDecoder.decodeObjectForKey("name") as? String
        self.picture  = aDecoder.decodeObjectForKey("picture") as? String
        self.provider  = aDecoder.decodeObjectForKey("provider") as? String
        self.verified  = aDecoder.decodeObjectForKey("verified") as? NSNumber
        self.images = aDecoder.decodeObjectForKey("images") as? NSNumber
        self.friends = aDecoder.decodeObjectForKey("friends") as? NSNumber
        self.badges = aDecoder.decodeObjectForKey("badges") as? NSNumber
    }
 
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "me")
    }
    
    class func loadSaved() -> Me? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("me") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Me
        }
        return nil
    }
    
    class func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("me")
    }
}
