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
  
  func solve2() -> Int {
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
        if field[neededField] == nil || !validateField(field: neededField, value: field[neededField]!) {
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
  
  private func match(_ string: String, toRegex: String) -> Bool {
    let range = NSRange(location: 0, length: string.utf16.count)
    let regex = try! NSRegularExpression(pattern: toRegex)
    return regex.firstMatch(in: string, options: [], range: range) != nil
  }
  
  private func validateField(field: String, value: String) -> Bool {
    switch field {
    case "byr":
      guard match(value, toRegex: "^\\d{4}$") else { return false }
      guard let year = Int(value) else { return false }
      return year >= 1920 && year <= 2002
    case "iyr":
      guard match(value, toRegex: "^\\d{4}$") else { return false }
      guard let year = Int(value) else { return false }
      return year >= 2010 && year <= 2020
    case "eyr":
      guard match(value, toRegex: "^\\d{4}$") else { return false }
      guard let year = Int(value) else { return false }
      return year >= 2020 && year <= 2030
    case "hgt":
      guard match(value, toRegex: "^\\d+(cm|in)$") else { return false }
      let height = Int(value.dropLast(2))!
      let units = value.suffix(2)
      switch units {
      case "cm":
        return height >= 150 && height <= 193
      case "in":
        return height >= 59 && height <= 76
      default:
        return false
      }
    case "hcl":
      return match(value, toRegex: "^#[0-9a-fA-F]{6}$")
    case "ecl":
      let colours: Set = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
      return colours.contains(value)
    case "pid":
      return match(value, toRegex: "^\\d{9}$")
    default:
      return false
    }
  }
  
  
}
