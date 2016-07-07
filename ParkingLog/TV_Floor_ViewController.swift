//
//  TV_Floor_ViewController.swift
//  ParkingLog
//
//  Created by Tony Lam on 21/05/2016.
//  Copyright © 2016 Tony Lam. All rights reserved.
//

import UIKit

protocol TV_Floor_View_Delegate  {
    func setFloor(floor: String)
}

class TV_Floor_ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let numberArray = ["-4","-3","-2","-1","0","1","2","3","4","5","6","7","8","9"]
    
    var delegate:TV_Floor_View_Delegate! = nil
    var floorText:String! = ""

    @IBOutlet weak var tv_floor_picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.

        if ( floorText != "" )
        {
            for i in 0 ..< numberArray.count
            {
                if ( numberArray[i] == floorText )
                {
                    tv_floor_picker.selectRow(i, inComponent: 0, animated: true)
                }
            }
        }
        else
        {
            // default to select floor 0
            tv_floor_picker.selectRow(4, inComponent: 0, animated: true)
        }
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // User selected [row], should do something with numberArray[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func confirm_btn_onTouch(sender: AnyObject) {
        delegate.setFloor(numberArray[tv_floor_picker.selectedRowInComponent(0)])
        self.dismissViewControllerAnimated(true, completion: nil);
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
