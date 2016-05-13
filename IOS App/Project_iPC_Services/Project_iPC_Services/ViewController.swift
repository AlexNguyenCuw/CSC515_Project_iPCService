//
//  ViewController.swift
//  Project_iPC_Services
//
//  Created by Nghia Nguyen on 5/2/16.
//  Copyright © 2016 Nghia Nguyen. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension UIViewController
{
    @IBAction func firebaseLogout (sender: AnyObject)
    {
        Core.fireBaseRef.unauth()
        self.view.window!.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
  
}


