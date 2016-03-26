/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert (title: String, message: String) {
        
        var alert = UIAlertController (title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func signUp(sender: AnyObject) {
       
        if username.text == "" || password.text == "" {
            
displayAlert("Error in form", message: "Please enter a username and password")
            
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var user = PFUser()
            user.username = username.text
            user.password = password.text
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
             
                var errorMessage:String = "Please try again later"
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    
                    //signup sucessful
                    
                } else
                    if let errorString = error?.userInfo["error"] as? String {
                        
                        errorMessage = errorString
                        
                }
                
                self.displayAlert("Failed Signup", message: errorMessage)
            
            })
        }
        
    }
    
    @IBAction func LogIn(sender: AnyObject) {
        
        
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
