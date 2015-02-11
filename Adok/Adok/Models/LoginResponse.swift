//
//  LoginResponse.swift
//  Adok
//
//  Created by Remi Robert on 11/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class LoginResponse: NSObject {
    var access_token: String!
    var refresh_token: String!
    var expires_in: NSNumber!
    var token_type: String!
}
