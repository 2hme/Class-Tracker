//
//  SignUpViewController.swift
//  classAttendance
//
//  Created by pramono wang on 11/20/15.
//  Copyright © 2015 Marshall Sprigg. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //call createUser
        //createUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //A function to create a user with the user name, id, and password
    func createUser(){
        let userName = nameTextField.text
        let userPassword =  passwordTextField.text
        let userEmailAddress = idTextField.text
        
        let user = PFUser()
        user.username = userName
        user.password = userPassword
        user.email = userEmailAddress
        
        user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
            print("User has been saved.")
        }
    }
    

    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
        var message = ""
        
        if (passwordTextField.text == "" || self.nameTextField.text == "" || self.idTextField.text == "")
        {
            message = "All the required field must be filled"
            
            let alertView = UIAlertController(title: "Fail To Log In", message: message, preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)
        }
        
        else{
             createUser()
        }
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
