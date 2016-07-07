//
//  TV_TableViewCell.swift
//  ParkingLog
//
//  Created by Tony Lam on 26/05/2016.
//  Copyright © 2016 Tony Lam. All rights reserved.
//

import UIKit

class TV_TableViewCell: UITableViewCell {

    @IBOutlet weak var tvc_time_label: UILabel!
    
    @IBOutlet weak var tvc_floor_imageView: UIImageView!
    
    @IBOutlet weak var tvc_area_view: UIView!
    @IBOutlet weak var tvc_area_label: UILabel!
    
    @IBOutlet weak var tvc_space_view: UIView!
    @IBOutlet weak var tvc_space_label: UILabel!
    
    @IBOutlet weak var tvc_direction_imageView: UIImageView!
    @IBOutlet weak var tvc_description_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell (record: Record_Text)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        tvc_time_label.text = dateFormatter.stringFromDate(record.time!)
        
        if ( record.floor != "" )
        {
            tvc_floor_imageView.image = UIImage(named: record.getFloorNumImage())
            tvc_floor_imageView.frame = CGRect(x: 167, y: 0, width: tvc_floor_imageView.frame.size.width, height: tvc_floor_imageView.frame.size.height)
            tvc_floor_imageView.hidden = false
        }
        else
        {
            tvc_floor_imageView.hidden = true
        }
        
        if ( record.area != "" )
        {
            tvc_area_label.text = record.area
            tvc_area_view.frame = CGRect(x: 167, y: 0, width: tvc_area_view.frame.size.width, height: tvc_area_view.frame.size.height)
            
            if ( record.floor != "" )
            {
                tvc_floor_imageView.frame = CGRect(x: 145, y: 0, width: tvc_floor_imageView.frame.size.width, height: tvc_floor_imageView.frame.size.height)
                tvc_area_view.frame = CGRect(x: tvc_floor_imageView.frame.origin.x + 45, y: 0, width: tvc_area_view.frame.size.width, height: tvc_area_view.frame.size.height)
            }
            tvc_area_view.hidden = false
        }
        else
        {
            tvc_area_view.hidden = true
        }
        
        if ( record.space != "" )
        {
            tvc_space_label.font = UIFont(name: "Press Start 2P", size: record.getSpaceFontSize())
            tvc_space_label.text = record.space
            tvc_space_view.frame = CGRect(x: 142, y: 0, width: tvc_space_view.frame.size.width, height: tvc_space_view.frame.size.height)
            
            if ( record.floor != "" )
            {
                if ( record.area != "" )
                {
                    tvc_floor_imageView.frame = CGRect(x: 90, y: 0, width: tvc_floor_imageView.frame.size.width, height: tvc_floor_imageView.frame.size.height)
                    tvc_area_view.frame = CGRect(x: tvc_floor_imageView.frame.origin.x + 45, y: 0, width: tvc_area_view.frame.size.width, height: tvc_area_view.frame.size.height)
                    tvc_space_view.frame = CGRect(x: tvc_area_view.frame.origin.x + 45, y: 0, width: tvc_space_view.frame.size.width, height: tvc_space_view.frame.size.height)
                }
                else
                {
                    tvc_floor_imageView.frame = CGRect(x: 130, y: 0, width: tvc_floor_imageView.frame.size.width, height: tvc_floor_imageView.frame.size.height)
                    tvc_space_view.frame = CGRect(x: tvc_floor_imageView.frame.origin.x + 45, y: 0, width: tvc_space_view.frame.size.width, height: tvc_space_view.frame.size.height)
                }
            }
            else if ( record.area != "")
            {
                tvc_area_view.frame = CGRect(x: 130, y: 0, width: tvc_area_view.frame.size.width, height: tvc_area_view.frame.size.height)
                tvc_space_view.frame = CGRect(x: tvc_area_view.frame.origin.x + 45, y: 0, width: tvc_space_view.frame.size.width, height: tvc_space_view.frame.size.height)
            }
            
            tvc_space_view.hidden = false
        }
        else
        {
            tvc_space_view.hidden = true
        }
        
        if ( record.direction != "" )
        {
            tvc_direction_imageView.image = UIImage(named: record.getDirectionImage())
            tvc_direction_imageView.frame = CGRect(x: 167, y: 0, width: tvc_direction_imageView.frame.size.width, height: tvc_direction_imageView.frame.size.height)
            
            if ( record.floor != "" )
            {
                if ( record.area != "" )
                {
                    if ( record.space != "" )
                    {
                        tvc_floor_imageView.frame = CGRect(x: 74, y: 0, width: tvc_floor_imageView.frame.size.width, height: tvc_floor_imageView.frame.size.height)
                        tvc_area_view.frame = CGRect(x: tvc_floor_imageView.frame.origin.x + 45, y: 0, width: tvc_area_view.frame.size.width, height: tvc_area_view.frame.size.height)
                        tvc_space_view.frame = CGRect(x: tvc_area_view.frame.origin.x + 45, y: 0, width: tvc_space_view.frame.size.width, height: tvc_space_view.frame.size.height)
                        tvc_direction_imageView.frame = CGRect(x: tvc_space_view.frame.origin.x + 95, y: 0, width: tvc_direction_imageView.frame.size.width, height: tvc_direction_imageView.frame.size.height)
                    }
                    else
                    {
                        tvc_floor_imageView.frame = CGRect(x: 110, y: 0, width: tvc_floor_imageView.frame.size.width, height: tvc_floor_imageView.frame.size.height)
                        tvc_area_view.frame = CGRect(x: tvc_floor_imageView.frame.origin.x + 45, y: 0, width: tvc_area_view.frame.size.width, height: tvc_area_view.frame.size.height)
                        tvc_direction_imageView.frame = CGRect(x: tvc_area_view.frame.origin.x + 45, y: 0, width: tvc_direction_imageView.frame.size.width, height: tvc_direction_imageView.frame.size.height)
                    }
                }
                else if ( record.space != "" )
                {
                    tvc_floor_imageView.frame = CGRect(x: 90, y: 0, width: tvc_floor_imageView.frame.size.width, height: tvc_floor_imageView.frame.size.height)
                    tvc_space_view.frame = CGRect(x: tvc_floor_imageView.frame.origin.x + 45, y: 0, width: tvc_space_view.frame.size.width, height: tvc_space_view.frame.size.height)
                    tvc_direction_imageView.frame = CGRect(x: tvc_space_view.frame.origin.x + 95, y: 0, width: tvc_direction_imageView.frame.size.width, height: tvc_direction_imageView.frame.size.height)
                }
                else
                {
                    tvc_floor_imageView.frame = CGRect(x: 145, y: 0, width: tvc_floor_imageView.frame.size.width, height: tvc_floor_imageView.frame.size.height)
                    tvc_direction_imageView.frame = CGRect(x: tvc_floor_imageView.frame.origin.x + 45, y: 0, width: tvc_direction_imageView.frame.size.width, height: tvc_direction_imageView.frame.size.height)
                }
            }
            else if ( record.area != "" )
            {
                if ( record.space != "" )
                {
                    tvc_area_view.frame = CGRect(x: 90, y: 0, width: tvc_area_view.frame.size.width, height: tvc_area_view.frame.size.height)
                    tvc_space_view.frame = CGRect(x: tvc_area_view.frame.origin.x + 45, y: 0, width: tvc_space_view.frame.size.width, height: tvc_space_view.frame.size.height)
                    tvc_direction_imageView.frame = CGRect(x: tvc_space_view.frame.origin.x + 95, y: 0, width: tvc_direction_imageView.frame.size.width, height: tvc_direction_imageView.frame.size.height)
                }
                else
                {
                    tvc_area_view.frame = CGRect(x: 145, y: 0, width: tvc_area_view.frame.size.width, height: tvc_area_view.frame.size.height)
                    tvc_direction_imageView.frame = CGRect(x: tvc_area_view.frame.origin.x + 45, y: 0, width: tvc_direction_imageView.frame.size.width, height: tvc_direction_imageView.frame.size.height)
                }
            }
            else if ( record.space != "" )
            {
                tvc_space_view.frame = CGRect(x: 130, y: 0, width: tvc_space_view.frame.size.width, height: tvc_space_view.frame.size.height)
                tvc_direction_imageView.frame = CGRect(x: tvc_space_view.frame.origin.x + 95, y: 0, width: tvc_direction_imageView.frame.size.width, height: tvc_direction_imageView.frame.size.height)
            }
            
            tvc_direction_imageView.hidden = false
        }
        else
        {
            tvc_direction_imageView.hidden = true
        }
        
        tvc_description_label.text = record.toString()

    }
}
