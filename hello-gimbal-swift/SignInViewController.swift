//
//  SignInViewController.swift
//  classAttendance
//
//  Created by pramono wang on 11/20/15.
//  Copyright © 2015 Marshall Sprigg. All rights reserved.
//

import Parse
import UIKit

class SignInViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    @IBOutlet weak var signInTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    
    override func viewDidLoad() {
        
        self.signInTextField.text = ""
        self.passwordTextField.text = ""
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonPressed(sender: AnyObject) {
        
        
        activityIndicator.startAnimating()
//        var message = ""
//    
//        if (passwordTextField.text == "" || self.signInTextField == "")
//        {
//            message = "All the required field must be filled"
//            
//            let alertView = UIAlertController(title: "Fail To Log In", message: message, preferredStyle: .Alert)
//            alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
//            self.presentViewController(alertView, animated: true, completion: nil)
//        }
//        else
//        {
//            if (passwordTextField == "student")
//            {
//                self.performSegueWithIdentifier("StudentMainMenu", sender: self)
//            }
//            else if (passwordTextField == "professor")
//            {
//                self.performSegueWithIdentifier("ProfessorMainMenu", sender: self)
//            }
//        }
        
        
        
        activityIndicator.stopAnimating()
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "SignInToCourseSegue") {
            let email = self.signInTextField.text
            let password = self.passwordTextField.text
            
            if let email = email, password = password {
                do {
                    try PFUser.logInWithUsername(email, password: password)
                    return true
                } catch {
                    return false
                }
                
            }
        }
        
        return false
    }
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
        //self.performSegueWithIdentifier("SignUpPage", sender: self)
        
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
