# Advent of code 2021 - day 8
# https://adventofcode.com/2021/day/8

def clue_to_bits(clue):
    i = 0
    chars = "abcdefg"
    ret = 0b0000000
    for c in range(0, 7):
        if clue.find(chars[i]) != -1:
            ret |= 0b0000001 << i
        i+=1
    return ret

def solve(filename, part):
    f = open(filename, "rt")
    inputLines = f.readlines()

    if part == 0:
        total = 0
        for line in inputLines:
            parts = line.split(" | ")
            words = parts[1].strip("\n").split(" ")
            for word in words:
                wordLength = len(word)
                if wordLength == 2 or wordLength == 3 or wordLength == 4 or wordLength == 7:
                    total += 1
        return total
    else:
        total = 0
            
        for line in inputLines:
            parts = line.split(" | ")
            words = parts[1].strip("\n").split(" ")
            clues = parts[0].split(" ")

            numberBits = []
            for i in range(0, 10):
                numberBits.append(0)

            fiveBits = []
            sixBits = []

            for clue in clues:
                clueLength = len(clue)
                clueBits = clue_to_bits(clue)
                if clueLength == 2:
                    numberBits[1] = clueBits
                elif clueLength == 3:
                    numberBits[7] = clueBits
                elif clueLength == 4:
                    numberBits[4] = clueBits
                elif clueLength == 5:
                    fiveBits.append(clueBits)
                elif clueLength == 6:
                    sixBits.append(clueBits)
                else:
                    numberBits[8] = clueBits

            threeLines = fiveBits[0] & fiveBits[1] & fiveBits[2]
            numberBits[3] = numberBits[1] | threeLines
            numberBits[9] = numberBits[4] | threeLines
            sixXOR = sixBits[0] ^ sixBits[1] ^ sixBits[2]
            numberBits[5] = sixXOR | threeLines
            numberBits[2] = (~numberBits[5] | threeLines) & 127
            numberBits[6] = (numberBits[5] | ~numberBits[9]) & 127
            centerLine = threeLines & numberBits[4]
            numberBits[0] = ~centerLine & 127

            lineValue = 0
            for word in words:
                lineValue *= 10
                digitBits = clue_to_bits(word)
                for i in range(0, 10):
                    if digitBits == numberBits[i]:
                        lineValue += i

            total += lineValue

        return total

print("Test 1:" + str(solve("8/test.txt", 0)))
print("Test 2:" + str(solve("8/test.txt", 1)))
print("Puzzle 1:" + str(solve("8/input.txt", 0)))
print("Puzzle 2:" + str(solve("8/input.txt", 1)))
