import Cocoa

// load the input
let inputUrl = Bundle.main.url(forResource: "input", withExtension: "")
let input = try String(contentsOf: inputUrl!)

func solve(numSantas: Int) -> Int
{
    var presentCount: [String:Int] = [:]
    var xLoc: [Int] = []
    var yLoc: [Int] = []
    
    // initialise
    for _ in 0...numSantas {
        xLoc.append(0)
        yLoc.append(1)
    }
    var iSanta = 0
    for direction in input {
        // deliver present to current location
        let locKey = "\(xLoc[iSanta])-\(yLoc[iSanta])"
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
            yLoc[iSanta] -= 1
        case "v":
            yLoc[iSanta] += 1
        case "<":
            xLoc[iSanta] -= 1
        case ">":
            xLoc[iSanta] += 1
        default:
            break
        }
        iSanta += 1
        iSanta %= numSantas
    }

    return presentCount.count
}

print("Answer 1:\(solve(numSantas:1))")
print("Answer 2:\(solve(numSantas:2))")
