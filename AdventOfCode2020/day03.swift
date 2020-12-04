//
//  day03.swift
//  AdventOfCode2020
//
//  Created by David Rak on 04.12.2020.
//

import Foundation

class Day03 {
  
  let filePath = "../files/AoC2020-day03.txt"
  let landscape: [[Character]]
  
  init() {
    do {
      let content = try String(contentsOfFile: filePath)
      self.landscape = content
        .components(separatedBy: "\n")
        .filter { $0.count > 0 }
        .map { Array($0) }
      print("File has been read.")
    }
    catch let error as NSError {
      self.landscape = [[]]
      print("Ooops, something went wrong: \(error)")
    }
  }
  
  
  func solve() -> (Int) {
    let toRight = 3
    let toDown = 1
    return countTrees(slope: (toRight, toDown))
  }
  
  func solve2() -> (Int) {
    let slopes = [
      (1, 1),
      (3, 1),
      (5, 1),
      (7, 1),
      (1, 2)
    ]
    var results = [Int]()
    for slope in slopes {
      results.append(countTrees(slope: slope))
    }
    return(results.reduce(1, *))
  }
  
  
  private func countTrees(slope: (Int, Int)) -> Int {
    let rowLength = landscape[0].count
    var x = 0, y = 0
    let (toRight, toDown) = slope
    var hittedTrees = 0
    while y <= landscape.count - 1 {
      if landscape[y][x] == "#" {
        hittedTrees += 1
      }
      x += toRight
      if x > rowLength - 1 { x -= rowLength }
      y += toDown
    }
    return(hittedTrees)
  }

}
