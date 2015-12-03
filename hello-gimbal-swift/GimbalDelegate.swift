//
//  GimbalDelegate.swift
//  ClassTracker
//
//  Created by Xi Han on 11/24/15.
//  Copyright © 2015 Marshall Sprigg. All rights reserved.
//

import Foundation
import Parse


class GimbalDelegate: NSObject, GMBLPlaceManagerDelegate {
    
    static let sharedInstance = GimbalDelegate()
    var placeManager: GMBLPlaceManager?
    
    override private init() {
        super.init()
        Gimbal.setAPIKey("4fb62693-73dd-42fe-ae00-e3972ed40df2", options: nil)
        self.placeManager = GMBLPlaceManager()
        self.placeManager!.delegate = self
        GMBLPlaceManager.startMonitoring()
        
        GMBLCommunicationManager.startReceivingCommunications()
    }
    
    func placeManager(manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) {
        /* Check if a user has logged in */
        if (PFUser.currentUser() == nil) {
            return
        }
        print("entered classroom")
        
        /* TODO: Maybe notify the user that he/she has entered a classroom */
    }
    
    func placeManager(manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) {
        /* Check if a user has logged in */
        if (PFUser.currentUser() == nil) {
            return
        }
        print("left classroom")
        let classroomId = visit.place.name
        let currentUser = PFUser.currentUser()!
        
        // Check if the present period is valid.
        // First, find all the classes in the classroom.
        let query = PFQuery(className: "Class")
        query.whereKey("classroom", equalTo: PFObject(withoutDataWithClassName: "Classroom", objectId: classroomId))
        query.findObjectsInBackgroundWithBlock() { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        /* Then, search for the attendance. */
                        let query = PFQuery(className: "Attendance")
                        query.whereKey("user", equalTo: currentUser)
                        query.whereKey("class", equalTo: object)
                        query.whereKey("endAt", greaterThan: visit.arrivalDate)
                        query.whereKey("beginAt", lessThan: visit.departureDate)
                        
                        /* Mark all attendance to be true */
                        query.findObjectsInBackgroundWithBlock() { (objects: [PFObject]?, error: NSError?) -> Void in
                            if error == nil {
                                if let objects = objects {
                                    print(objects.count)
                                    for object in objects {
                                        object["attended"] = true
                                        object.saveInBackgroundWithBlock() { (succeeded: Bool, error: NSError?) -> Void in
                                            NSNotificationCenter.defaultCenter().postNotificationName("AttendanceRefreshed", object: nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}