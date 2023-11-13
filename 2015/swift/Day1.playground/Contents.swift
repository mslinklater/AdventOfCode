import Cocoa

// load the input
let inputUrl = Bundle.main.url(forResource: "day1", withExtension: "txt")
let input = try String(contentsOf: inputUrl!)

var floor = 0
var lastFloor = 0
var enterBasement: Int?
var index = 1
for c in input {
    lastFloor = floor
    if c == "(" {
        floor += 1
    } else {
        floor -= 1
    }
    if enterBasement == nil && floor == -1 && lastFloor == 0 {
        enterBasement = index
    }
    index += 1
}
print("Part 1: \(floor)")
print("Part 2: \(enterBasement!)")
