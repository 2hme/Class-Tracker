//
//  StudyList.swift
//  Class Tracker
//
//  Created by Stephen Link on 11/23/15.
//  Copyright © 2015 Marshall Sprigg. All rights reserved.
//

import UIKit

class CourseLog
{
    var className: String
    var classAttendance: NSDate?
    
    
    init (className: String, classAttendance: NSDate?)
    {
        self.className = className
        self.classAttendance = classAttendance
        
    }
    
    
}
