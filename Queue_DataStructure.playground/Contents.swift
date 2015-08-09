//: Playground - noun: a place where people can play

import UIKit

//08-06-15: DATA STRUCTURE THURSDAY: Implement a queue.

class Queue {
  
  class func enqueue(inputArray: [String], queueItem: String) -> [String]{
    var queue = [String]()
    queue = inputArray
    queue.insert(queueItem, atIndex: 0)
    return queue
    
  }
  
  class func dequeue(inputArray: [String]) -> [String] {
    var queue = [String]()
    queue = inputArray
    queue.removeAtIndex(inputArray.count - 1)
    return queue
  }
}

var items = [String]()

items = Queue.enqueue(items, queueItem: "Bye 1st")
items = Queue.enqueue(items, queueItem: "Goodbye 2nd")
items = Queue.enqueue(items, queueItem: "So Long 3rd")
items = Queue.enqueue(items, queueItem: "See ya 4th")
items = Queue.enqueue(items, queueItem: "Ta Ta 5th")


items = Queue.dequeue(items)
items = Queue.dequeue(items)
items = Queue.dequeue(items)
items = Queue.dequeue(items)
items = Queue.dequeue(items)





