//
//  UserTimelineViewController.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController {

  var username: String!
  
  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "Tweets")
      
      self.tableView.dataSource = self
      
        TwitterService.getUserTimelineInfo(username!, account: TwitterService.sharedService.account!, completionHandler: { (errorDescription, UserInfo) -> (Void) in
        if let userInfo = UserInfo {
           //NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
          
           //self.activityIndicator.stopAnimating()
           // self.tableView.reloadData()
        // }
       }
        
      })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension UserTimelineViewController: UITableViewDataSource {
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
    
  }
  
  func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    
   return cell
  }

  
}

