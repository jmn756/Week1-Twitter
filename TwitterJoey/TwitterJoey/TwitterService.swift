//
//  TwitterService.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/5/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import Foundation
import Accounts
import Social

//Brad Johnson code below...mostly

class TwitterService {
  
  var account: ACAccount?
  
  static let sharedService = TwitterService()
  private init() {}
  
  class func tweetsFromHomeTimeline(account : ACAccount, completionHandler : (String?, [Tweet]?) -> (Void)) {
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!, parameters: nil)
    request.account = account
    
    request.performRequestWithHandler { (data, response, error) -> Void in
      if let error = error {
        completionHandler("could not connect to the server", nil)
      } else {
        switch response.statusCode {
        case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          completionHandler(nil,tweets)
        case 400...499:
          completionHandler("this is our fault", nil)
        case 500...599:
          completionHandler("this is the servers fault", nil)
        default:
          completionHandler("error occurred", nil)
        }
        
      }
    }
    
  }
  
  class func getUserTimelineInfo(username: String, account : ACAccount, completionHandler : (String?, UserInfo?) -> (Void)) {
    
    let parameter = ["screen_name": username]
    
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json"), parameters: parameter)
    request.account = account
      
    request.performRequestWithHandler { (data, response, error) -> Void in
      if let error = error {
        completionHandler("could not connect to the server", nil)
      } else {
        switch response.statusCode {
        case 200...299:
          let userInfo = TweetJSONParser.userInfoFromJSONData(data)
          completionHandler(nil,userInfo)
        case 400...499:
          completionHandler("this is our fault", nil)
        case 500...599:
          completionHandler("this is the servers fault", nil)
        default:
          completionHandler("error occurred", nil)
        }
        
      }
    }
    
  }

  
  
  
}

