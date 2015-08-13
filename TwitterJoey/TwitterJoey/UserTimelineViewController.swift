//
//  UserTimelineViewController.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController {

  var screenName: String!
  var tweets = [Tweet]()
  lazy var imageQueue = NSOperationQueue()
  

  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var headerImage: UIImageView!
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "Tweets")
      
      tableView.estimatedRowHeight = 100
      tableView.rowHeight = UITableViewAutomaticDimension
      self.tableView.dataSource = self
      
     // self.activityIndicator.startAnimating()
      TwitterService.getUserTimelineInfo(screenName!, account: TwitterService.sharedService.account!, completionHandler: { (errorDescription, tweets) -> (Void) in
            if let tweets = tweets {
               NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                 //  self.activityIndicator.stopAnimating()
                     self.tweets = tweets
                     self.tableView.reloadData()
               })
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
    return tweets.count
    
  }
  
  func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  
    let cell = tableView.dequeueReusableCellWithIdentifier("Tweets", forIndexPath: indexPath) as! TweetCell
    
    cell.tag++
    let tag = cell.tag
    
    cell.tweetTextLabel.text = tweets[indexPath.row].text
    cell.usernameLabel.text = tweets[indexPath.row].name
    userLabel.text = tweets[indexPath.row].name
    locationLabel.text = tweets[indexPath.row].location 
    cell.tweetImage.image = nil
    
    //Brad Johnson code with some modifications
    if let profileImage = tweets[indexPath.row].profileImage {
      cell.tweetImage.image = profileImage
      headerImage.image = profileImage
    } else {
      //Profile Image generation
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
                self.headerImage.image = resizedImage
              }
            })
        }
      })
    }
    
   return cell
  }

  
}

