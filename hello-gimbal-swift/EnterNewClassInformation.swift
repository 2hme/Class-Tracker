//
//  EnterNewClassInformation.swift
//  Class Tracker
//
//  Created by Stephen Link on 11/23/15.
//  Copyright © 2015 Marshall Sprigg. All rights reserved.
//

import UIKit

class EnterNewClassInformation: UIViewController, UITextFieldDelegate
{
    
    var newclass: CourseLog? // "?" determines the property that the value may be nil, kinda like a null pointer
    
    @IBOutlet weak var classNameLabel: UILabel!
    
    
    @IBOutlet weak var classNameField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func cancelPressed(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input through delegate callbacks
        
        classNameField.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {

        if saveButton === sender
        {
            
            let name = classNameField.text ?? ""
            
            newclass = CourseLog(className: name, classAttendance: "Not yet attended")
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        classNameField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

