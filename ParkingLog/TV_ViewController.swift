//
//  SecondViewController.swift
//  ParkingLog
//
//  Created by Tony Lam on 21/05/2016.
//  Copyright © 2016 Tony Lam. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, TV_Floor_View_Delegate, TV_Area_View_Delegate, TV_Direction_View_Delegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tv_floor_textField: UITextField!
    @IBOutlet weak var tv_space_textField: UITextField!
    @IBOutlet weak var tv_area_textField: UITextField!
    @IBOutlet weak var tv_direction_textField: UITextField!
    
    @IBOutlet weak var tv_floor_edit_btn: UIButton!
    @IBOutlet weak var tv_area_edit_btn: UIButton!
    @IBOutlet weak var tv_direction_edit_btn: UIButton!
    
    @IBOutlet weak var tv_tableView: UITableView!
    
    var tvc_record_array: [Record_Text] = [Record_Text]()
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the edit buttons, only need segues from the buttons
        tv_floor_edit_btn.hidden = true
        tv_area_edit_btn.hidden = true
        tv_direction_edit_btn.hidden = true
        
        // Avoid the regular keyboard
        tv_floor_textField.inputView = UIView()
        tv_area_textField.inputView = UIView()
        tv_direction_textField.inputView = UIView()
        
        tv_space_textField.keyboardType = UIKeyboardType.NamePhonePad
        
        showRecords()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tv_tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvc_record_array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tv_tableView.dequeueReusableCellWithIdentifier("Cell") as! TV_TableViewCell
        
        let record = tvc_record_array[indexPath.row]
        
        cell.setCell(record)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            moc.deleteObject(tvc_record_array[indexPath.row] )
            tvc_record_array.removeAtIndex(indexPath.row)
            do {
                try moc.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
            // remove the deleted item from the `UITableView`
            tv_tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }

    @IBAction func tv_save_btn_onTouch(sender: AnyObject) {
        
        if ( tv_floor_textField.text != "" || tv_space_textField.text != "" || tv_area_textField.text != "" || tv_direction_textField.text != "" )
        {
            addRecord(tv_floor_textField.text!, space: tv_space_textField.text!, area: tv_area_textField.text!, direction: tv_direction_textField.text!)
            
            // will only show the added info to the table
            tv_tableView.reloadData()
            
            // the following is workaround for setCell() for the first load
            tv_tableView.setNeedsLayout()
            tv_tableView.layoutIfNeeded()
            tv_tableView.reloadData()
        }
        else
        {
            let remind_input_alert = UIAlertController(title: NSLocalizedString("remind_input_alert_title", comment:""), message:NSLocalizedString("remind_input_alert_message", comment:""), preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: NSLocalizedString("confirm", comment:""), style: .Default, handler: {
                (action:UIAlertAction) -> () in
            })
            
            remind_input_alert.addAction(okAction)
            self.presentViewController(remind_input_alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func tv_clear_btn_onTouch(sender: AnyObject) {
    
        clearRecords()
    }
    
    func showRecords() {
        
        let request = NSFetchRequest(entityName: "Record_Text")
        do {
            tvc_record_array = try moc.executeFetchRequest(request) as! [Record_Text]
            
        }
        catch {
            fatalError("Failed to fetch data: \(error)")
        }
        tv_tableView.reloadData()
    }
    
    func clearRecords() {
        
        let confirm_clear_alert = UIAlertController(title: NSLocalizedString("tv_confirm_clear_alert_title", comment:""), message:NSLocalizedString("tv_confirm_clear_alert_message", comment:""), preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: NSLocalizedString("confirm", comment:""), style: .Default, handler: {
            (action:UIAlertAction) -> () in
            let request = NSFetchRequest(entityName: "Record_Text")
            do {
                let results = try self.moc.executeFetchRequest(request) as! [Record_Text]
                for result in results {
                    self.moc.deleteObject(result)
                }
                do {
                    try self.moc.save()
                }catch{
                    fatalError("Failure to save context: \(error)")
                }
            }catch{
                fatalError("Failed to fetch data: \(error)")
            }
            
            self.tvc_record_array.removeAll()
            self.tv_tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment:""), style: .Default, handler: {
            (action:UIAlertAction) -> () in
        })
        
        confirm_clear_alert.addAction(okAction)
        confirm_clear_alert.addAction(cancelAction)
        self.presentViewController(confirm_clear_alert, animated: true, completion: nil)
    }
    
    
    func addRecord(floor:String, space:String, area:String, direction:String) {
        
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Record_Text", inManagedObjectContext: self.moc) as! Record_Text
        
        entity.floor = floor
        entity.space = space
        entity.area = area
        if ( direction != "" ){
            // When save, change all direction into "SW" format
            entity.direction = NSLocalizedString(direction, comment:"")
        }else{
            entity.direction = direction
        }
        entity.time = NSDate()
        
        do {
            try self.moc.save()
        }
        catch
        {
            fatalError("Failure to save context: \(error)")
        }
        
        tvc_record_array.append(entity)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tv_floor_clear_onTouch(sender: AnyObject) {
        tv_floor_textField.text = ""
    }
    
    @IBAction func tv_space_clear_onTouch(sender: AnyObject) {
        tv_space_textField.text = ""
    }
    
    @IBAction func tv_area_clear_onTouch(sender: AnyObject) {
        tv_area_textField.text = ""
    }
    
    @IBAction func tv_direction_clear_onTouch(sender: AnyObject) {
        tv_direction_textField.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "tv_floor_segue" ){
            let destination = segue.destinationViewController as! TV_Floor_ViewController
            destination.floorText = tv_floor_textField.text
            destination.delegate = self
        }
        else if ( segue.identifier == "tv_area_segue" ){
            let destination = segue.destinationViewController as! TV_Area_ViewController
            destination.areaText = tv_area_textField.text
            destination.delegate = self
        }
        else if ( segue.identifier == "tv_direction_segue" ){
            let destination = segue.destinationViewController as! TV_Direction_ViewController
            destination.result_direction = tv_direction_textField.text!
            destination.delegate = self
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if ( textField == tv_floor_textField )
        {
            performSegueWithIdentifier("tv_floor_segue", sender: self)
        }
        else if ( textField == tv_area_textField )
        {
            performSegueWithIdentifier("tv_area_segue", sender: self)
        }
        else if ( textField == tv_direction_textField )
        {
            performSegueWithIdentifier("tv_direction_segue", sender: self)
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func setFloor(floor: String) {
        tv_floor_textField.text = floor
    }
    
    func setArea(area: String) {
        tv_area_textField.text = area
    }
    
    func setDirection(direction: String) {
        tv_direction_textField.text = direction
    }
}

