//
//  UserTimelineViewController.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController {

  
    var tweet: Tweet?
    var username: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
    TwitterService.getUserTimelineInfo(username!, account: TwitterService.sharedService.account!, completionHandler: { (errorDescription, tweets) -> (Void) in
       // if let tweets = tweets {
       //   NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
       //     self.tweets = tweets
       //     self.activityIndicator.stopAnimating()
       //     self.tableView.reloadData()
        //  }
      //  }
        
      })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
