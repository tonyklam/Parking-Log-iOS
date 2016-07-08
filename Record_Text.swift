//
//  Record_Text.swift
//  ParkingLog
//
//  Created by Tony Lam on 26/05/2016.
//  Copyright © 2016 Tony Lam. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Record_Text: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func toString() -> String
    {
        var output_txt: String = ""
        
        output_txt = "Pakred at"
        
        if ( floor != "" )
        {
            output_txt += " " + floor! + " Floor";
        }
        if ( area != "" )
        {
            output_txt += " at Area " + area!
        }
        if ( space != "" )
        {
            output_txt += " in Space " + space!
        }
        if ( direction != "" )
        {
            output_txt += ", go " + direction! + " after lift"
        }
        
        return output_txt + ".\n"
    }
    
    func getFloorNumImage() -> String
    {
        if ( floor != "" )
        {
            let number:Character = floor![floor!.endIndex.predecessor()]
            
            if ( floor!.characters.count == 1 )
            {
                return "num_\(number)_icon.png"
            }
            else if ( floor!.characters.count == 2 )
            {
                return "num_n\(number)_icon.png"
            }
        }
        return "num_q_icon.png"
    }
    
    func getDirectionImage() -> String
    {
        let direction_dictionary: [String: String] = ["SW":"1","S":"2","SE":"3","W":"4","E":"6","NW":"7","N":"8","NE":"9"]
        
        if ( direction != "" )
        {
            return "direction_"+direction_dictionary[direction!]!+"_icon.png"
        }
        else
        {
            return "direction_8_icon.png"
        }
    }
    
    func getSpaceFontSize() -> CGFloat
    {
        if ( space != "" )
        {
            if ( space!.characters.count <= 3 )
            {
                return CGFloat(20)
            }
            else if ( space!.characters.count == 4 )
            {
                return CGFloat(18)
            }
            else
            {
                return CGFloat(16)
            }
        }
        return CGFloat(2)
    }
}
