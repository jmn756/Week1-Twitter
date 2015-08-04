//
//  Tweet.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/3/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import Foundation

struct Tweet {
  let text: String
  let id_str: String
  let user: [String: AnyObject]
  let profile_image_url: String
}
