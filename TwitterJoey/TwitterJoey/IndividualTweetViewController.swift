//
//  IndividualTweetViewController.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class IndividualTweetViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var tweet: Tweet?
  var endingUserName: String
  
    override func viewDidLoad() {
        super.viewDidLoad()

      if let tweetCell = NSBundle.mainBundle().loadNibNamed("TweetCell", owner: self, options: nil).first as? TweetCell {
        view.addSubview(tweetCell)
      }
      
      tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "Tweets")
      
      self.tableView.dataSource = self
      self.tableView.delegate = self
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowUserTimeline" {
      let userTimelineViewController = segue.destinationViewController as! UserTimelineViewController
      userTimelineViewController.navigationItem.title = "User Timeline"
      userTimelineViewController.username = endingUserName
    }
  }

}

extension IndividualTweetViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
    
  }
  
  func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Tweets", forIndexPath: indexPath) as! TweetCell
   
    cell.tweetImage.image = tweet!.profileImage
    cell.tweetTextLabel.text = tweet!.text
    cell.usernameLabel.text = tweet!.name
    
    if let retweetedText = tweet!.retweeted_original_text {
      cell.tweetTextLabel.text = retweetedText
      cell.usernameLabel.text = tweet!.retweeted_original_name
    }
    
    if let quotedText = tweet!.quoted_original_text {
      cell.tweetTextLabel.text = quotedText
      cell.usernameLabel.text = tweet!.quoted_original_name
    }
    endingUserName = cell.usernameLabel.text!
    
    return cell
  }
  
  
}

extension IndividualTweetViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowUserTimeline", sender: self)
  }
}


