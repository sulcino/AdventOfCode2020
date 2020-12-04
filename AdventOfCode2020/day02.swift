//
//  day02.swift
//  AdventOfCode2020
//
//  Created by David Rak on 02.12.2020.
//

import Foundation

class Day02 {
  
  let filePath = "../files/AoC2020-day02.txt"
  let lines: [String]
  
  init() {
    do {
      let content = try String(contentsOfFile: filePath)
      self.lines = content.components(separatedBy: "\n").filter { $0.count > 0 }
      print("File has been read.")
    }
    catch let error as NSError {
      self.lines = []
      print("Ooops, something went wrong: \(error)")
    }
  }
  
  
  func solve() -> (Int, Int) {
    let data = lines.map { parseData($0) }
    var counter = 0
    var counter2 = 0
    for block in data {
      counter += checkBlock(block)
      counter2 += checkBlockNew(block)
    }
    return (counter, counter2)
  }
  
  
  private func parseData(_ data: String) -> [Any] {
    let parts = data.components(separatedBy: " ")
    return [parseRange(parts[0]), parts[1].dropLast(), parts[2]]
  }
  
  private func parseRange(_ string: String) -> (Int, Int) {
    let numbers = string.components(separatedBy: "-").map { Int($0) }
    return (numbers[0]!, numbers[1]!)
  }
  
  private func checkBlock(_ block: [Any]) -> Int {
    let password = block[2] as! String
    let range = block[0] as! (Int, Int)
    let character = Character(String(block[1] as! Substring))
    let charCount = password.filter { $0 == character }.count
    let (min, max) = range
    return (charCount >= min && charCount <= max) ? 1 : 0
  }
  
  private func checkBlockNew(_ block: [Any]) -> Int {
    let password = block[2] as! String
    let range = block[0] as! (Int, Int)
    let (first, second) = range
    let character = Character(String(block[1] as! Substring))
    let char1 = password[password.index(password.startIndex, offsetBy: first - 1)]
    let char2 = password[password.index(password.startIndex, offsetBy: second - 1)]
    if (character == char1 || character == char2) && char1 != char2 {
      return 1
    } else{
      return 0
    }
  }
  
}
