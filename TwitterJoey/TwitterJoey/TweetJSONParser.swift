//
//  TweetJSONParser.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/4/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import Foundation

class TweetJSONParser {
  class func tweetsFromJSONData(jsonData : NSData) -> [Tweet]? {
    
    var error: NSError?
    var tweets = [Tweet]()
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]] {
        
        for tweetRecord in rootObject {
          
          if let text = tweetRecord["text"] as? String,
           id_str = tweetRecord["id_str"] as? String,
          user = tweetRecord["user"] as? [String:AnyObject],
            profile_image_url = user["profile_image_url"] as? String
          {
            let tweet = Tweet(text: text, id_str: id_str, user: user, profile_image_url: profile_image_url)
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
}

