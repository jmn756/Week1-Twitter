//: Playground - noun: a place where people can play

import UIKit

//CODING CHALLENGE: Return the number of times that the string "hi" appears anywhere in the given string.

func hiCount (var input: String) -> Int {
  var ctr = 0
  var pos = true
  if !isEmpty(input) {
  while pos == true {
     if let found = input.rangeOfString("hi") {
        ctr += 1
       let range = Range(start: advance(found.startIndex, 2), end: input.endIndex)
        input = input.substringWithRange(range)
        println(input)
      } else {
        pos = false
      }
    }
  }
    return ctr
  }



var times: Int
times = hiCount("say hihi")
times = hiCount("there")
times = hiCount("hi")
times = hiCount("")
times = hiCount("hihihihihi")







