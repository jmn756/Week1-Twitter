//
//  ViewController.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/3/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var tweets = [Tweet]()

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Brad Johnson code below
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println(errorDescription)
      }
      if let account = account {
        TwitterService.tweetsFromHomeTimeline(account, completionHandler: { (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
              self.tweets = tweets
              self.tableView.reloadData()
            }
          }
          
        })
        
      }
    }
    
    self.tableView.dataSource = self
   // self.tableView.reloadData()
   // if let filepath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
   //   if let data = NSData(contentsOfFile: filepath) {
   //     if let tweets = TweetJSONParser.tweetsFromJSONData(data) {
   //       self.tweets = tweets
   //     }
    //  }
   // }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
    
  }
  
  func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Tweets", forIndexPath: indexPath) as! UITableViewCell
    cell.textLabel?.text = tweets[indexPath.row].text
    return cell
  }
  
  
}

