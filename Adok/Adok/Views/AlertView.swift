//
//  AlertView.swift
//  Adok
//
//  Created by Remi Robert on 06/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class AlertView: NSObject {
   
    class func displayAlertView(parentView: UIView, title: String, message: String?) {
        let alertView = UIAlertView(title: title, message: ((message == nil) ? "" : message!), delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok")
        parentView.addSubview(alertView)
        alertView.show()
    }
}
