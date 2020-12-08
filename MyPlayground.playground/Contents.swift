// import Cocoa
import Foundation

let string = "2010"
let range = NSRange(location: 0, length: string.utf16.count)
let regex = try! NSRegularExpression(pattern: "\\d{4}")
let result = regex.firstMatch(in: string, options: [], range: range) != nil
print(result)
