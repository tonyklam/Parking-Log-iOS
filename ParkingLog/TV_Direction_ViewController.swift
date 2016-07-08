//
//  TV_Direction_ViewController.swift
//  ParkingLog
//
//  Created by Tony Lam on 24/05/2016.
//  Copyright © 2016 Tony Lam. All rights reserved.
//

import UIKit

protocol TV_Direction_View_Delegate  {
    func setDirection(direction: String)
}

class TV_Direction_ViewController: UIViewController {
       
    var delegate:TV_Direction_View_Delegate! = nil
    var directionText:String! = nil
    var result_direction:String = ""
    
    @IBOutlet var direction_btns: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if ( result_direction != "" )
        {
            for a_btn in direction_btns
            {
                if ( a_btn.currentTitle == result_direction )
                {
                    a_btn.selected = true
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func direction_btn_onTouch(sender: UIButton) {
        
        result_direction = sender.currentTitle!
        
        sender.selected = true
        
        for a_btn in direction_btns
        {
            if ( a_btn != sender )
            {
                a_btn.selected = false
            }
        }
    }
    
    
    @IBAction func confirm_btn_onTouch(sender: AnyObject) {
        if ( result_direction != "" )
        {
            delegate.setDirection(result_direction)
        }
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
