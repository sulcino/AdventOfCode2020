//
//  day04.swift
//  AdventOfCode2020
//
//  Created by David Rak on 05.12.2020.
//

import Foundation

class Day04 {
  
  let filePath = "../files/AoC2020-day04.txt"
  var passports = [[String:String]]()
  
  
  init() {
    do {
      let content = try String(contentsOfFile: filePath)
        .replacingOccurrences(of: " ", with: "\n")
        .components(separatedBy: "\n")
      self.passports = convertPassports(content)
      print("File has been read.")
    }
    catch let error as NSError {
      self.passports = [[:]]
      print("Ooops, something went wrong: \(error)")
    }
  }
  
  
  func solve() -> (Int) {
    let neededFields = [
      "byr",
      "iyr",
      "eyr",
      "hgt",
      "hcl",
      "ecl",
      "pid"
    ]
    let countValid = passports.reduce(0, { counter, field in
      for neededField in neededFields {
        if field[neededField] == nil {
          return counter
        }
      }
      return counter + 1
    })
    return countValid
  }
  
  
  private func convertPassports(_ data: [String]) -> [[String:String]] {
    var passports = [[String: String]]()
    var passport = [String: String]()
    for row in data {
      if row == "" {
        passports.append(passport)
        passport = [:]
      } else {
        let parsedRow = row.components(separatedBy: ":")
        passport[parsedRow[0]] = parsedRow[1]
      }
    }
    return passports
  }
  
}
