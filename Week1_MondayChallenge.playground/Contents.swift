//: Playground - noun: a place where people can play

import UIKit

var array = ["Apple", "Bear", "Cat", "Dog"]
var genArray = [1,2,3,4]


func reverseArrayGen<T: Equatable>(inout input: [T]) {
  var newArray = [T]()
  for (var i = input.count-1; i >= 0; i--) {
    newArray.append(input[i])
  }
  input = newArray
}

reverseArrayGen(&genArray)
println(genArray)

reverseArrayGen(&array)
println(array)



