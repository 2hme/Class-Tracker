//
//  CourseLogViewController.swift
//  Class Tracker
//
//  Created by Stephen Link on 11/23/15.
//  Copyright © 2015 Marshall Sprigg. All rights reserved.
//

import UIKit
import Parse

class CourseLogTableViewController: UITableViewController, GMBLPlaceManagerDelegate {

    var courses = [CourseLog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set color of app pages 
        self.tableView.setEditing(false, animated: false)
        self.navigationController?.setEditing(false, animated: false)
        self.navigationController?.navigationItem.leftBarButtonItem = nil
        //handleRefresh
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
       
        loadClasses()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onAttendanceRefreshed:", name: "AttendanceRefreshed", object: nil)
    }
    
    func onAttendanceRefreshed(notification: NSNotification) {
        loadClasses()
    }
    
    func loadClasses() {
        courses = []
        if let currentUser = PFUser.currentUser() {
            currentUser.fetchInBackgroundWithBlock() { (object: PFObject?, error: NSError?) -> Void in
                if error == nil {
                    if let currentUser = object {
                        // print(object)
                        for classId in currentUser["enrolledClasses"] as! [String] {
                            let query = PFQuery(className: "Attendance")
                            query.whereKey("user", equalTo: currentUser)
                            query.whereKey("class", equalTo: PFObject.init(withoutDataWithClassName: "Class", objectId: classId))
                            query.whereKey("attended", equalTo: true)
                            query.orderByDescending("endAt")
                            query.findObjectsInBackgroundWithBlock() { (objects: [PFObject]?, error: NSError?) -> Void in
                                if error == nil {
                                    if let objects = objects {
                                        
                                        if objects.count > 0 {
                                            let query = PFQuery(className: "Class")
                                            query.whereKey("objectId", equalTo: classId)
                                            query.getFirstObjectInBackgroundWithBlock() { (object: PFObject?, error: NSError?) -> Void in
                                                if error == nil {
                                                    if let object = object {
                                                        self.courses.append(CourseLog(className: (object["name"] as! String), classAttendance: (objects.first!.updatedAt!)))
                                                    }
                                                }
                                                self.tableView.reloadData()
                                            }
                                        } else {
                                            let query = PFQuery(className: "Class")
                                            query.whereKey("objectId", equalTo: classId)
                                            query.getFirstObjectInBackgroundWithBlock() { (object: PFObject?, error: NSError?) -> Void in
                                                if error == nil {
                                                    if let object = object {
                                                        self.courses.append(CourseLog(className: (object["name"] as! String), classAttendance: nil))
                                                    }
                                                }
                                                self.tableView.reloadData()
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
    
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        loadClasses()
        self.tableView.reloadData()
        for visit in GimbalDelegate.sharedInstance.placeManager!.currentVisits() {
            print(visit as! GMBLVisit)
        }
        refreshControl.endRefreshing()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // only 1 section necessary for our app
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // return number of rows from the table
        // print(courses.count)
        return courses.count
    }
    //It’s most efficient for table views to only ask for the cells for rows that are being displayed, and that’s what tableView(_:cellForRowAtIndexPath:) allows the table view to do.
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cellIdentifier = "CourseLogTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CourseLogTableViewCell

        let courseRN = courses[indexPath.row]
        
        cell.nameLabel.text = courseRN.className
        
        //configure HOW TO mark attendance////
        
        if let attendance = courseRN.classAttendance {
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            formatter.timeStyle = .ShortStyle
            cell.attendanceLabel.text = "Last Attended At: " + formatter.stringFromDate(attendance)
        } else {
            cell.attendanceLabel.text = "Never attended"
        }
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
