//
//  Tweet.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/3/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

struct Tweet {
  let text: String
  let id_str: String
  let name: String
  let screen_name: String
  let profile_image_url: String
  var profileImage : UIImage?
  let retweeted_original_name: String?
  let retweeted_original_text: String?
  let retweeted_original_screen_name: String?
  let quoted_original_name: String?
  let quoted_original_text: String?
  let quoted_original_screen_name: String?
  //specific user info below
  let profile_background_image_url: String
  let profileBackgroundImage: UIImage?
  let location: String
}
