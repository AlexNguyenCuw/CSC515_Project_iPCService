//
//  UserSettingsVC.swift
//  Project_iPC_Services
//
//  Created by Nghia Nguyen on 5/9/16.
//  Copyright © 2016 Nghia Nguyen. All rights reserved.
//

import UIKit
import Firebase

class UserSettingsVC: UIViewController {
    @IBOutlet weak var errorTV: UITextView!
    @IBOutlet weak var firstNameTF: UITextField!
     @IBOutlet weak var lastNameTF: UITextField!
     @IBOutlet weak var address1TF: UITextField!
     @IBOutlet weak var address2TF: UITextField!
     @IBOutlet weak var cityTF: UITextField!
     @IBOutlet weak var stateTF: UITextField!
     @IBOutlet weak var zipTF: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        errorTV.hidden = true
    }

func validateForm() -> Bool
    {
        var msg = ""
        if(firstNameTF.text == "")
        {
            msg = "You must enter an First Name"
        }
        else if(lastNameTF.text == "")
        {
            msg = "You must enter an Last Name"
        }
        else if(address1TF.text == "")
        {
            msg = "You must enter address1"
        }
        else if(cityTF.text == "")
        {
            msg = "You must enter a City"
        }
        else if(stateTF.text == "")
        {
            msg = "You must enter a State"
        }
        else if(zipTF.text == "")
        {
            msg = "You must enter a Zip"
        }
        if (msg != "")
        {
            errorTV.text = msg
            errorTV.textColor = UIColor.redColor()
            errorTV.hidden = false
            return false
        }
        errorTV.text = ""
        errorTV.hidden = true
        return true
    }

    @IBAction func updateButtonPressed(sender:AnyObject)
    {
        if(self.validateForm())
        {
            let ref = Core.fireBaseRef.childByAppendingPath("profile").childByAppendingPath(Core.fireBaseRef.authData.uid)
            var dictionary = [String : AnyObject]()
            dictionary["first_name"] = self.firstNameTF.text!
            dictionary["last_name"] = self.lastNameTF.text!
            dictionary["address1"] = self.address1TF.text!
            dictionary["address2"] = self.address2TF.text!
            dictionary["city"] = self.cityTF.text!
            dictionary["state"] = self.stateTF.text!
            dictionary["zip"] = self.zipTF.text!
            ref.setValue(dictionary, withCompletionBlock: { (error: NSError!, firebase: Firebase!) in
                
            })
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
