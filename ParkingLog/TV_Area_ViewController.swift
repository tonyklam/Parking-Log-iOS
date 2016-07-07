//
//  TV_Area_ViewController.swift
//  ParkingLog
//
//  Created by Tony Lam on 21/05/2016.
//  Copyright © 2016 Tony Lam. All rights reserved.
//

import UIKit

protocol TV_Area_View_Delegate  {
    func setArea(area: String)
}

class TV_Area_ViewController: UIViewController {

    let alphabetArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var delegate:TV_Area_View_Delegate! = nil
    var areaText:String! = ""
    
    @IBOutlet weak var tv_area_picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if ( areaText != "" )
        {
            for i in 0 ..< alphabetArray.count
            {
                if ( alphabetArray[i] == areaText )
                {
                    tv_area_picker.selectRow(i, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return alphabetArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return alphabetArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // User selected [row], should do something with numberArray[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func confirm_btn_onTouch(sender: AnyObject) {
        delegate.setArea(alphabetArray[tv_area_picker.selectedRowInComponent(0)])
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
