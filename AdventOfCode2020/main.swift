//
//  main.swift
//  AdventOfCode2020
//
//  Created by David Rak on 02.12.2020.
//

import Foundation

func run() {
  let arguments = CommandLine.arguments
  let day = Int(arguments[1]) ?? 0
  print("day: \(day)")
  		
  switch day {
  case 1:
    let solver = Day01()
//    print(solver.solve())
    print(solver.solve2())
  case 2:
    let solver = Day02()
    print(solver.solve())
  case 3:
    let solver = Day03()
    print(solver.solve2())
  default:
    print("Day not recognized!")
  }
}

run()
