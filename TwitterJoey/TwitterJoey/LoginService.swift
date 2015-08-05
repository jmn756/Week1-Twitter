//
//  LoginService.swift
//  TwitterJoey
//
//  Created by Joey Nessif on 8/5/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import Foundation
import Accounts

//Brad Johnson's code below
class LoginService {
  class func loginForTwitter(completionHandler : (String?, ACAccount?) -> (Void)) {
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      if let error = error {
        completionHandler("Please sign in",nil)
        return
      } else {
        if granted {
          if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
            completionHandler(nil,account)
          }
        } else {
          //tell the user this app needs twitter
          completionHandler("This app requires twitter access",nil)
          
        }
      }
    }
  }

}
