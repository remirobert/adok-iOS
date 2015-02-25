//
//  Upload.swift
//  Adok
//
//  Created by Remi Robert on 25/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class Upload: NSObject {
   
    class func uploadImage(file: UIImage, url: String, token: String,
        blockCompletion completion:()->(),
        blockFailCompletion completionFail: ()->()) {
        
            if let url = NSURL(string: url) {
                let request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 60)
                request.HTTPMethod = "PUT"
                
                let boundary = "boundarystring"
                request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                let body = NSMutableData()
                
                body.appendData(NSString(format: "\r\n--\(boundary)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
                body.appendData(NSString(format: "Content-Disposition: form-data; name=\"file\"; filename=\"photo.jpg\"\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
                body.appendData(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
                body.appendData(UIImageJPEGRepresentation(file, 0.8))
                body.appendData(NSString(format: "\r\n--\(boundary)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    println("response : \(response)")
                    println("error : \(error)")
                })
            }
            
    }
    
}
