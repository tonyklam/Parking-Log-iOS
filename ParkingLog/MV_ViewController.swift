//
//  FirstViewController.swift
//  ParkingLog
//
//  Created by Tony Lam on 21/05/2016.
//  Copyright © 2016 Tony Lam. All rights reserved.
//

import UIKit
import Photos

class FirstViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TV_Floor_View_Delegate {

    @IBOutlet weak var mv_background_scrollView: UIScrollView!
    @IBOutlet weak var mv_background_imageView: UIImageView!
    @IBOutlet weak var mv_original_btn: UIButton!
    @IBOutlet weak var mv_floor_btn: UIButton!
    @IBOutlet weak var mv_output_label: UILabel!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    let imagePicker:UIImagePickerController! = UIImagePickerController()
    var imageURL:String = ""
    
    var x_float:CGFloat = -1
    var y_float:CGFloat = -1
    var parked_floor:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        load_recorded_bg_image()
        load_recorded_pin()
        load_recorded_floor()
        set_output_text()
        
        setZoomScale()
        mv_background_imageView.userInteractionEnabled = true
        mv_background_imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FirstViewController.didTapImage(_:))))
    }
    
    func didTapImage(gesture: UIGestureRecognizer) {
        let point:CGPoint = gesture.locationInView(gesture.view)
        put_a_pin(point.x, y_float: point.y)
        
        //Since users have to be reminded about saving the new pin                
        mv_output_label.text = NSLocalizedString("mv_output_label", comment:"")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return mv_background_imageView
    }
    
    func setZoomScale() {
        let imageViewSize = mv_background_imageView.bounds.size
        let scrollViewSize = mv_background_scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        mv_background_scrollView.minimumZoomScale = min(widthScale, heightScale)
        mv_background_scrollView.maximumZoomScale = 3.0
        mv_background_scrollView.zoomScale = 1.0
    }
    
    func put_a_pin(x_float: CGFloat, y_float: CGFloat){
        let pin = UIImage(named: "mf_car_icon.png")
        let pin_view = UIImageView(image: pin)
        
        pin_view.frame = CGRect(x: x_float-20, y: y_float-20, width: 40, height: 40)
        
        remove_all_pins()
        
        self.x_float = x_float
        self.y_float = y_float
        
        mv_background_imageView.addSubview(pin_view) // Add the pin on top of the background
    }
    
    func remove_all_pins(){
        for v in mv_background_imageView.subviews{
            v.removeFromSuperview()
        }
    }
    
    func load_recorded_pin()
    {
       if let recorded:Bool = userDefaults.boolForKey("recorded")
       {
            if ( recorded )
            {
                put_a_pin(CGFloat(userDefaults.floatForKey("x_float")), y_float: CGFloat(userDefaults.floatForKey("y_float")))
            }
       }
    }
    
    func load_recorded_bg_image()
    {
        if let hasBgImage:Bool = userDefaults.boolForKey("hasBgImage")
        {
            if ( hasBgImage )
            {
                if let imageData = userDefaults.objectForKey("bg_image")
                {
                    mv_background_imageView.image = UIImage(data: imageData as! NSData)
                    mv_original_btn.hidden = false
                    return
                }
            }
        }
        
        // Else
        mv_background_imageView.image = UIImage(named:"mf_background_0.png")
        mv_original_btn.hidden = true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let referenceURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        imageURL = referenceURL.absoluteString
        
        let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        //Save Image to Camera Roll
        //UIImageWriteToSavedPhotosAlbum(mv_background_imageView.image!, nil, nil, nil)
        
        //Save Image to userDefaults
        let imageData: NSData = UIImageJPEGRepresentation(pickedImage!, 1.0)!
        userDefaults.setObject(imageData, forKey:"bg_image")
        userDefaults.setBool(true, forKey:"hasBgImage")
        userDefaults.synchronize()
        
        mv_background_imageView.image = UIImage(data: imageData)
        //mv_background_imageView.image = pickedImage
        
        self.dismissViewControllerAnimated(true, completion:{
            self.mv_original_btn.hidden = false
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func mv_photo_album_btn_onTouch(sender: UIButton) {
        if ( UIImagePickerController.isSourceTypeAvailable(.Camera) )
        {
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.delegate = self
            presentViewController(imagePicker, animated:true, completion: nil)
        }
    }
    
    @IBAction func mv_original_btn_onTouch(sender: UIButton) {
        
        let confirm_original_alert = UIAlertController(title: NSLocalizedString("confirm_original_alert_title", comment:""), message: NSLocalizedString("confirm_original_alert_message", comment:""), preferredStyle: .Alert)
               
        let okAction = UIAlertAction(title: NSLocalizedString("confirm", comment:""), style: .Default, handler: {
            (action:UIAlertAction) -> () in
            self.mv_background_imageView.image = UIImage(named:"mf_background_0.png")
            self.mv_original_btn.hidden = true
            self.userDefaults.setBool(false, forKey:"hasBgImage")
            self.userDefaults.synchronize()
        })
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment:""), style: .Default, handler: {
            (action:UIAlertAction) -> () in
        })
        
        confirm_original_alert.addAction(okAction)
        confirm_original_alert.addAction(cancelAction)
        self.presentViewController(confirm_original_alert, animated: true, completion: nil)
    }
    
    @IBAction func mv_clear_btn_onTouch(sender: AnyObject) {
        
        let confirm_clear_alert = UIAlertController(title: NSLocalizedString("mv_confirm_clear_alert_title", comment:""), message: NSLocalizedString("mv_confirm_clear_alert_message", comment:""), preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: NSLocalizedString("confirm", comment:""), style: .Default, handler: {
            (action:UIAlertAction) -> () in
            self.remove_all_pins()
            self.mv_floor_btn.setImage(UIImage(named: self.getFloorNumImage("")), forState: UIControlState.Normal)
            self.parked_floor = ""
            self.x_float = -1
            self.y_float = -1
            self.userDefaults.setFloat(Float(self.x_float), forKey:"x_float")
            self.userDefaults.setFloat(Float(self.y_float), forKey:"y_float")
            self.userDefaults.setObject(self.parked_floor, forKey:"floor")
            self.userDefaults.setBool(false, forKey:"recorded")
            self.userDefaults.synchronize()
            self.set_output_text()
        })
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment:""), style: .Default, handler: {
            (action:UIAlertAction) -> () in
        })
        
        confirm_clear_alert.addAction(okAction)
        confirm_clear_alert.addAction(cancelAction)
        self.presentViewController(confirm_clear_alert, animated: true, completion: nil)
        
    }
    
    func set_output_text()
    {
        let recorded:Bool = userDefaults.boolForKey("recorded")
        
        if ( recorded )
        {
            let time:String = userDefaults.objectForKey("time") as! String
            if ( parked_floor != "" )
            {
                mv_output_label.text = String.localizedStringWithFormat(NSLocalizedString("mv_output_label_see_pin_at_floor", comment: ""), time, parked_floor)
            }
            else
            {
                mv_output_label.text = String.localizedStringWithFormat(NSLocalizedString("mv_output_label_see_pin_below", comment: ""), time)
            }
        }
        else
        {
            if ( x_float != -1 && y_float != -1 )
            {
                mv_output_label.text = NSLocalizedString("mv_output_label_pls_save", comment:"")
            }
            else
            {
                mv_output_label.text = NSLocalizedString("mv_output_label_pls_pin", comment:"")
            }
        }
    }
    
    
    func fetchBackgroundImage(){
        if ( imageURL != "" )
        {
            print (imageURL)
            
            let data_URL = NSURL(string: imageURL)
            
            let tempResult = PHAsset.fetchAssetsWithALAssetURLs([data_URL!], options: nil)
            
            if ( tempResult.count > 0 )
            {
                let fetchResult = tempResult.firstObject as! PHAsset
                
                let manager = PHImageManager.defaultManager()
                let options = PHImageRequestOptions()
                options.synchronous = false
                options.resizeMode = .Exact
                options.deliveryMode = .HighQualityFormat
                
                manager.requestImageForAsset(fetchResult, targetSize: CGSize(width: mv_background_imageView.frame.width, height: mv_background_imageView.frame.height), contentMode: .AspectFit, options: options, resultHandler: {(result, info)->Void in
                    self.mv_background_imageView.image = result!
                })
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "mv_floor_segue" ){
            let destination = segue.destinationViewController as! TV_Floor_ViewController
            destination.delegate = self
        }
    }
    
    func setFloor(floor: String) {
        mv_floor_btn.setImage(UIImage(named: getFloorNumImage(floor)), forState: UIControlState.Normal)
        self.parked_floor = floor
    }
    
    func load_recorded_floor()
    {
        if let recorded:Bool = userDefaults.boolForKey("recorded")
        {
            if ( recorded )
            {
                parked_floor = userDefaults.objectForKey("floor") as! String
                mv_floor_btn.setImage(UIImage(named: getFloorNumImage(parked_floor)), forState: UIControlState.Normal)
            }
        }
    }

    
    @IBAction func mv_save_btn_onTouch(sender: UIButton) {
       
        if ( x_float != -1 && y_float != -1 )
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
            let time:String = dateFormatter.stringFromDate(NSDate())
            
            userDefaults.setObject(time, forKey:"time")
            userDefaults.setFloat(Float(x_float), forKey:"x_float")
            userDefaults.setFloat(Float(y_float), forKey:"y_float")
            userDefaults.setObject(parked_floor, forKey:"floor")
            userDefaults.setBool(true, forKey:"recorded")
            userDefaults.synchronize()
            
            set_output_text()
        }
        else
        {
            let remind_pin_alert = UIAlertController(title: NSLocalizedString("remind_pin_alert_title", comment:""), message: NSLocalizedString("remind_pin_alert_title", comment:""), preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: NSLocalizedString("confirm", comment:""), style: .Default, handler: {
                (action:UIAlertAction) -> () in
            })
            
            remind_pin_alert.addAction(okAction)
            self.presentViewController(remind_pin_alert, animated: true, completion: nil)
        }
        
    }
    
    

    func getFloorNumImage(floor: String) -> String
    {
        if ( floor != "" )
        {
            let number:Character = floor[floor.endIndex.predecessor()]
            
            if ( floor.characters.count == 1 )
            {
                return "num_\(number)_icon.png"
            }
            else if ( floor.characters.count == 2 )
            {
                return "num_n\(number)_icon.png"
            }
        }
        return "num_q_icon.png"
    }
}

