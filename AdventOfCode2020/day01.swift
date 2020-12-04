//
//  day01.swift
//  AdventOfCode2020
//
//  Created by David Rak on 02.12.2020.
//

import Foundation

class Day01 {
		
  let filePath = "../files/AoC2020-day01.txt"
  var numbers: [Int]
  
  
  init() {
    do {
      let content = try String(contentsOfFile: filePath)
      let lines = content.components(separatedBy: "\n")
      self.numbers = lines.filter { $0.count > 0 }.map { Int($0) ?? 0 }
      print("File has been read.")
    }
    catch let error as NSError {
      self.numbers = []
      print("Ooops, something went wrong: \(error)")
    }
  }
  
  
  func solve() -> Int {
    print("Accepted \(numbers.count) numbers.")
    while numbers.count > 1 {
      let n = numbers.removeFirst()
      for number in numbers {
        if n + number == 2020 {
          return n * number
        }
      }
    }
    return 0
  }
  
  func solve2() -> Int {
    let combs = combinations(array: numbers, number: 3)
    let suitable = combs.filter {
      return $0.reduce(0, +) == 2020
    }
    print("suitable combination: \(suitable)")
    print(suitable[0].reduce(0, +))
    return suitable[0].reduce(1, *)
  }
  
  
  private func combinations(array: Array<Int>, number: Int) -> [[Int]] {
    if number == 1 {
      return array.map { [$0] }
    }
    guard number > 0 else { return [[]] }
    guard number <= array.count else { return [[]] }
    guard number != array.count else { return [array] }

    var elements = array
    var result: [[Int]] = []
    while elements.count >= 2 {
      let element = elements.removeFirst()
      let restOfElements = combinations(array: elements, number: number - 1)
      for e in restOfElements {
        result.append([element] + e)
      }
    }
    return result
  }
  
}
