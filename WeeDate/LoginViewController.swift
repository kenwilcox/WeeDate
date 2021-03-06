//
//  LoginViewController.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 6/12/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func pressedFBLogin(sender: UIButton) {
    
    PFFacebookUtils.logInWithPermissions(["public_profile", "user_about_me", "user_birthday"], block: {
      user, error in
      if user == nil {
        println("Uh oh. The user cancelled the Facebook Login.")
        // TODO - present some error
        return
      } else if user!.isNew {
        println("User signed up and logged in through Facebook!")
        
        FBRequestConnection.startWithGraphPath("/me?fields=picture.height(720).width(720),first_name,birthday,gender", completionHandler: {
          connection, result, error in
          var r = result as! NSDictionary
          user!["firstName"] = r["first_name"]
          user!["gender"] = r["gender"]
          
          var dateFormatter = NSDateFormatter()
          dateFormatter.dateFormat = "MM/dd/yyyy"
          user!["birthday"] = dateFormatter.dateFromString(r["birthday"] as! String)
          
          let pictureUrl = ((r["picture"] as! NSDictionary)["data"] as! NSDictionary)["url"] as! String
          let url = NSURL(string: pictureUrl)
          let request = NSURLRequest(URL: url!)
          
          UIApplication.sharedApplication().networkActivityIndicatorVisible = true
          NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            let imageFile = PFFile(name: "avatar.jpg", data: data)
            user!["picture"] = imageFile
            //user!.saveInBackgroundWithBlock(nil)
            user!.saveInBackgroundWithBlock({
              success, error in
              println(success)
              println(error)
              UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
          })
        })
        
      } else {
        println("User logged in through Facebook!")
      }
      
//      let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as? UIViewController
//      self.presentViewController(vc!, animated: true, completion: nil)
      
      self.presentViewController(pageController, animated: true, completion: nil)
      
    })
  }
}
