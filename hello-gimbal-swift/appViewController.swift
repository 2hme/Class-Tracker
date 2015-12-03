import UIKit

class appViewController: UITableViewController, GMBLPlaceManagerDelegate{
    
    var placeManager: GMBLPlaceManager!
    var placeEvents : [GMBLVisit] = []
    
    

    //var beaconManager: GMBLBeaconManager!
    
    override func viewDidLoad() -> Void
    {

        Gimbal.setAPIKey("4fb62693-73dd-42fe-ae00-e3972ed40df2", options: nil)
        placeManager = GMBLPlaceManager()
        self.placeManager.delegate = self
        GMBLPlaceManager.startMonitoring()
        
        GMBLCommunicationManager.startReceivingCommunications()
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        NSLog("number of sections: %d", self.numberOfSectionsInTableView(self.tableView))
        NSLog("number of rows in the first section: %d", self.tableView(self.tableView, numberOfRowsInSection: 0))

    }
    
//    func beaconManager(manager: GMBLBeaconManager!, didReceiveBeaconSighting sighting: GMBLBeaconSighting!)
//    {
//        print("beacon was found")
//    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        //let newMovie = Movie(title: "Serenity", genre: "Sci-fi")
        //movies.append(newMovie)
        
        //movies.sort() { $0.title < $1.title }
//        
//        if (GMBLPlaceManager.isMonitoring())
//        {
//            GMBLPlaceManager.stopMonitoring()
//            GMBLPlaceManager.startMonitoring()
//        }
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func placeManager(manager: GMBLPlaceManager!, didBeginVisit visit: GMBLVisit!) -> Void
    {
        NSLog("Begin %@", visit.place.description)
        self.placeEvents.insert(visit, atIndex: 0)
        self.tableView.reloadData()
        
    }
    
    func placeManager(manager: GMBLPlaceManager!, didEndVisit visit: GMBLVisit!) -> Void
    {
        NSLog("End %@", visit.place.description)
        
        var i = 0
        
        while i < self.placeEvents.count {
            if self.placeEvents[i].arrivalDate == visit.arrivalDate &&
                self.placeEvents[i].place == visit.place {
                    break
            }
            ++i
        }
        
        if self.placeEvents.count > i && 0 <= i {
            self.placeEvents[i] = visit
        }
        self.tableView.reloadData()
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "obtainInfo")
        {
        var destViewController: CourseLogTableViewController = segue.destinationViewController as! CourseLogTableViewController
        
        for each in destViewController.courses
        {
            if (each.className == placeEvents[0].place.name){
                
                each.classAttendance = "Attended"
            }
            
        }
            
        }
        
    }
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: NSInteger) -> NSInteger
    {
        return self.placeEvents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let visit: GMBLVisit = self.placeEvents[indexPath.row]
        
        if (visit.departureDate == nil)
        {
            cell.textLabel!.text = NSString(format: "You have entered %@", visit.place.name, visit.arrivalDate) as String
            
            cell.detailTextLabel!.text = NSDateFormatter.localizedStringFromDate(visit.arrivalDate, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
            
        /*
            //check whether name of course matches with course log
        if (destViewController.courses.isEmpty)
        {
            //dont do anything
        }
        else
        {
            
            for index in (newclass.courses)
            {
                if(visit.place.name == index.className)
                {
                    index.classAttendance = "Attended"
                    //newclass.handleRefresh(UIControlEvents.ValueChanged)
                }
            }
            

        }
       */
        }
        else {
            cell.textLabel!.text = NSString(format: "You have attended class at %@", visit.place.name) as String
            cell.detailTextLabel!.text = NSDateFormatter.localizedStringFromDate(visit.arrivalDate, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
        }
        
        return cell
    }
}
