//
//  UserNewServiceRequest.swift
//  ProjectiPCServices
//
//  Created by Nghia Nguyen on 4/26/16.
//  Copyright © 2016 iLash. All rights reserved.
//

import UIKit
import Stripe
import Alamofire
import Firebase

class UserNewServiceRequest: UIViewController,
    STPPaymentCardTextFieldDelegate
{
    
    @IBOutlet weak var typeSegments:
        UISegmentedControl!
    
    @IBOutlet weak var currentPriceLabel:
    UILabel!
    
    @IBOutlet weak var specialInstructionsTV:
    UITextView!
    
    @IBOutlet weak var paymentTextField:
        STPPaymentCardTextField!
    var currentPricePerMinutes = 10.0
    var currentNumberOfMinutes = 0.0
    var currentPrices = 0.0
    var name = "software"
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
    }
    
    @IBAction func segmentsValueChange(sender:
        UISegmentedControl)
    {
        if(sender.selectedSegmentIndex == 0)
        {
            self.currentPricePerMinutes = 10
            name = "software"
        }
        else
        {
            self.currentPricePerMinutes = 8
            name = "hardware"
        }
        self.updatePriceLabel()
    }
    
    func updatePriceLabel ()
    {
        self.currentPrices = self.currentNumberOfMinutes * self.currentPricePerMinutes
        self.currentPriceLabel.text = "$\(self.currentPrices)"

    }
    
    @IBAction func numberOfMinutesValueChange(sender :
        UITextField)
    {
       if (sender.text! == "")
       {
         return
        }
        self.currentNumberOfMinutes = Double(sender.text!)!
        self.updatePriceLabel()
    }
    
    func processPayment ()
    {
        STPAPIClient.sharedClient().createTokenWithCard(self.paymentTextField.cardParams) {(token : STPToken?, error: NSError?) in
        let parameters = [
                "stripeToken" : token!.tokenId,
                "amount" : self.currentPrices*100]
                Alamofire.request(.POST, "http://localhost:3000/checkout",
                parameters: parameters as? [String : AnyObject]).response(completionHandler: { (req, res, data, error) in
                    let responseData = String(data: data!, encoding: NSUTF8StringEncoding)
                if(responseData == "success")
                {
                   let ref = Core.fireBaseRef.childByAppendingPath("service_requests").childByAutoId()
                    var dictionary = [String: AnyObject] ()
                    dictionary["completed"] = false
                    dictionary["cost"] = self.currentPrices*100
                    dictionary["instructions"] = self.specialInstructionsTV.text
                    dictionary["name"] = self.name
                    dictionary["provider"] = "n/a"
                    dictionary["numberOfMinutes"] = "\(self.currentNumberOfMinutes)"
                    dictionary["type"] = self.name
                    dictionary["user"] = Core.fireBaseRef.authData.uid
                    ref.setValue(dictionary, withCompletionBlock: { (error, firebase) in
                        if(error == nil)
                        {
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                    })

                }
                    
            })
            
            
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
   @IBAction func saveButtonPressed(sender : AnyObject)
    {
            self.processPayment()
    }
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        // Toggle navigation, for example
        //saveButton.enabled = textField.valid
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
