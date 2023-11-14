import Cocoa

// load the input
let inputUrl = Bundle.main.url(forResource: "input", withExtension: "")
let input = try String(contentsOf: inputUrl!)

// part 1
var presentCount: [String:Int] = [:]
var xLoc: Int = 0
var yLoc: Int = 0
for direction in input {
    // deliver present to current location
    let locKey = "\(xLoc)-\(yLoc)"
    if presentCount[locKey] == nil {
        presentCount[locKey] = 1
    } else {
        var currentOpt = presentCount[locKey]
        if let current = currentOpt {
            presentCount[locKey] = current + 1
        } else {
            assert(false, "presentCount contained non-Int value")
        }
    }
    switch direction {
    case "^":
        yLoc -= 1
    case "v":
        yLoc += 1
    case "<":
        xLoc -= 1
    case ">":
        xLoc += 1
    default:
        break
    }
}

print("Answer 1:\(presentCount.count)")
