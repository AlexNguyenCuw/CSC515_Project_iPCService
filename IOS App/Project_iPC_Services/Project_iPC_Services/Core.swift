//
//  Core.swift
//  communifime
//
//  Created by Nghia Nguyen on 4/20/16.
//  Copyright © 2016 Communifime. All rights reserved.
//

import UIKit
import Firebase

class Core: NSObject
{
    static var storyboard : UIStoryboard!
    
    static var fireBaseRef = Firebase(url: "https://projectipcservice.firebaseio.com/")
    
    static func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
}
