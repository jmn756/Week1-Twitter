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
  lazy var imageQueue = NSOperationQueue()

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let tweetCell = NSBundle.mainBundle().loadNibNamed("TweetCell", owner: self, options: nil).first as? TweetCell {
      view.addSubview(tweetCell)
    }
    
    tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "Tweets")

    self.tableView.estimatedRowHeight = 100
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    
    //Brad Johnson code below
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println(errorDescription)
      }
      if let account = account {
        TwitterService.sharedService.account = account
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.activityIndicator.startAnimating()
        })
        TwitterService.tweetsFromHomeTimeline(account, completionHandler: { (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
              self.tweets = tweets
              self.activityIndicator.stopAnimating()
              self.tableView.reloadData()
            }
          }
          
        })
        
      }
    }
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
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

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  if segue.identifier == "ShowIndividualTweet" {
    let individualTweetViewController = segue.destinationViewController as! IndividualTweetViewController
    var selectedIndexPath = self.tableView.indexPathForSelectedRow()
    var selectedTweet = self.tweets[selectedIndexPath!.row]
    individualTweetViewController.navigationItem.title = "Tweet"
    individualTweetViewController.tweet = selectedTweet
  }
}

}

extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
    
  }
  
  func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Tweets", forIndexPath: indexPath) as! TweetCell
    
    cell.tag++
    let tag = cell.tag

    cell.tweetTextLabel.text = tweets[indexPath.row].text
    cell.usernameLabel.text = tweets[indexPath.row].name
    cell.tweetImage.image = nil
    
    //Brad Johnson code with some modifications
    if let profileImage = tweets[indexPath.row].profileImage {
      cell.tweetImage.image = profileImage
    } else {
      
      imageQueue.addOperationWithBlock({ () -> Void in
        if let imageURL = NSURL(string: self.tweets[indexPath.row].profile_image_url),
          imageData = NSData(contentsOfURL: imageURL),
          image = UIImage(data: imageData) {
            var size : CGSize
            switch UIScreen.mainScreen().scale {
            case 2:
              size = CGSize(width: 160, height: 160)
            case 3:
              size = CGSize(width: 240, height: 240)
            default:
              size = CGSize(width: 80, height: 80)
            }
            
            let resizedImage = ImageResizer.resizeImage(image, size: size)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.tweets[indexPath.row].profileImage = resizedImage
              if cell.tag == tag {
                cell.tweetImage.image = resizedImage
              }
            })
        }
      })
    }
 
    return cell
  }
  
}

extension ViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      performSegueWithIdentifier("ShowIndividualTweet", sender: self)
  }
}

