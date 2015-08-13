//
//  TweetJSONParser.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/4/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class TweetJSONParser {
  class func tweetsFromJSONData(jsonData : NSData) -> [Tweet]? {
    
    var error: NSError?
    var tweets = [Tweet]()
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]] {
        
        for tweetRecord in rootObject {
          
          var retweeted_original_name: String?
          var retweeted_original_text: String?
          var retweeted_original_screen_name: String?
          var quoted_original_name: String?
          var quoted_original_text: String?
          var quoted_original_screen_name: String?
          
          if let retweeted_status = tweetRecord["retweeted_status"] as? [String:AnyObject] {
            let retweet_user = retweeted_status["user"] as! [String:AnyObject]
            retweeted_original_name = retweet_user["name"] as? String
            retweeted_original_text = retweeted_status["text"] as? String
            retweeted_original_screen_name = retweet_user["screen_name"] as? String
          }
          if let quoted_status = tweetRecord["quoted_status"] as? [String:AnyObject] {
            let quoted_user = quoted_status["user"] as! [String:AnyObject]
            quoted_original_name = quoted_user["name"] as? String
            quoted_original_text = quoted_status["text"] as? String
            quoted_original_screen_name = quoted_user["screen_name"] as? String
          }


          if let text = tweetRecord["text"] as? String,
             id_str = tweetRecord["id_str"] as? String,
             user = tweetRecord["user"] as? [String:AnyObject],
             name = user["name"] as? String,
             screen_name = user["screen_name"] as? String,
             profile_image_url = user["profile_image_url"] as? String,
             profile_background_image_url = user["profile_background_image_url"] as? String,
             location = user["location"] as? String
          {
            let tweet = Tweet(text: text, id_str: id_str, name: name, screen_name: screen_name, profile_image_url: profile_image_url,profileImage: nil, retweeted_original_name: retweeted_original_name,retweeted_original_text: retweeted_original_text,
              retweeted_original_screen_name: retweeted_original_screen_name,
              quoted_original_name: quoted_original_name,quoted_original_text: quoted_original_text,
              quoted_original_screen_name: quoted_original_screen_name,
              profile_background_image_url: profile_background_image_url, profileBackgroundImage: nil, location: location)
            
            tweets.append(tweet)
          } else {
            println("There is a problem with your data")
          }
        }
    }

    if let error = error {
      println(error.description)
      return nil
    } else {
      return tweets
    }
    
  }
  
  
//  class func userInfoFromJSONData(jsonData : NSData) -> [Tweet]? {
//    
//    var error: NSError?
//    var tweets = [Tweet]()
//    
//    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]] {
//      
//      for userEntry in rootObject {
//        
//        if let user = userEntry["user"] as? [String:AnyObject],
//        name = user["name"] as? String,
//        profile_background_image_url = user["profile_background_image_url"] as? String,
//        profile_image_url = user["profile_image_url"] as? String,
//        location = user["location"] as? String
//        {
//          userInfo = UserInfo(name: name, profile_background_image_url: profile_background_image_url,
//            profileBackgroundImage: nil, profile_image_url: profile_image_url,profileImage: nil, location:location)
//          
//        } else {
//          println("There is a problem with your data")
//        }
//      }
//    }
//    
//    if let error = error {
//      println(error.description)
//      return nil
//    } else {
//      return tweets
//    }
//    
//  }
  
}

