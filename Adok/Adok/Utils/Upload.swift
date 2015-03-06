//
//  Upload.swift
//  Adok
//
//  Created by Remi Robert on 25/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class Upload: NSObject {
   
    class func uploadImage(file: UIImage, url: String, token: String, httpMethod: String,
        blockCompletion completion:()->(),
        blockFailCompletion completionFail: (error: NSError!)->()) {
        
            if let url = NSURL(string: url) {
                let request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60)
                request.HTTPMethod = httpMethod
                
                let boundary = "----------V2ymHFg03esomerandomstuffhbqgZCaKO6jy"
                request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                let body = NSMutableData()
                body.appendData(NSString(format: "--\(boundary)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
                
                body.appendData(NSString(format: "Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
                body.appendData(NSString(format: "Content-Type: image/jpeg\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
                body.appendData(UIImageJPEGRepresentation(file, 0.8))
                body.appendData(NSString(format: "\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
                body.appendData(NSString(format: "\r\n--\(boundary)--\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
                
                request.HTTPBody = body
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    
                    if error == nil && (response as! NSHTTPURLResponse).statusCode == 200 {
                        completion()
                    }
                    else {
                        completionFail(error: error)
                    }
                })
            }
    }
    
}
