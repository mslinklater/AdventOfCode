import Cocoa

// load the input
let inputUrl = Bundle.main.url(forResource: "day2", withExtension: "")
let input = try String(contentsOf: inputUrl!)
let inputLines = input.split(whereSeparator: \.isNewline)

var answer1: Int = 0
var answer2: Int = 0
for line in inputLines {
    let dimensions = line.split(separator: "x")
    assert(dimensions.count == 3)
    let w = Int(dimensions[0])
    let h = Int(dimensions[1])
    let d = Int(dimensions[2])
    if let w = w, let h = h, let d = d {
        let end1 = w * h
        let end2 = w * d
        let end3 = h * d
        answer1 += end1 * 2 + end2 * 2 + end3 * 2
        let smallestEnd = min(end1, min(end2, end3))
        answer1 += smallestEnd
        
        let perim1 = (w + h) * 2
        let perim2 = (w + d) * 2
        let perim3 = (h + d) * 2
        let smallestPerim = min(perim1, min(perim2, perim3))
        let volume = w * h * d
        answer2 += smallestPerim + volume
    } else {
        assert(false, "Int conversions failed")
    }
}

print("Answer 1: \(answer1)")
print("Answer 2: \(answer2)")
