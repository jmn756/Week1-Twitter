//: Playground - noun: a place where people can play

import UIKit

//CODING CHALLENGE: Given a string, return a version where all the "x" have been removed. Except an "x" at the very start or end should not be removed.


func removeInnerX (var input: String) -> String {
  let startRange = advance(input.startIndex, 1)
  let endRange = input.endIndex
  let length = distance(startRange, endRange)-1
  
  let searchRange = startRange..<advance(startRange, length)
  var workingStr = input
  var pos = true
  if !isEmpty(workingStr) {
    while pos == true {
      if let found = workingStr.rangeOfString("x", options: nil, range: searchRange) {
        workingStr.removeAtIndex(found.startIndex)
      } else {
        pos = false
      }
    }
  }
  return workingStr
}

var removedx: String
removedx = removeInnerX("Xray")
removedx = removeInnerX("Xrxay")
removedx = removeInnerX("Appxle")
removedx = removeInnerX("XrayX")
removedx = removeInnerX("none")




