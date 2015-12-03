//
//  CourseLogTableViewCell.swift
//  Class Tracker
//
//  Created by Stephen Link on 11/23/15.
//  Copyright © 2015 Marshall Sprigg. All rights reserved.
//

import UIKit

class CourseLogTableViewCell : UITableViewCell
{
    
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    
}
