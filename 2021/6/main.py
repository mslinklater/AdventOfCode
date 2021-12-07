# Advent of code 2021 - day 6
# https://adventofcode.com/2021/day/6

def solve(filename, iterations):
    class Fish:
        def __init__(self):
            self.age = 9

    f = open(filename, "rt")
    inputLines = f.readlines()

    startFish = inputLines[0].split(",")

    fishCounts = []
    for i in range(0,9):
        fishCounts.append(0)
        
    for fish in startFish:
        fishCounts[int(fish)] += 1

    for i in range(0,iterations):
        zeroFish = fishCounts[0]
        for j in range(0,8):
            fishCounts[j] = fishCounts[j+1]
        fishCounts[8] = zeroFish
        fishCounts[6] += zeroFish
    total = 0
    for i in range(0, 9):
        total += fishCounts[i]
    return total

print("Test:" + str(solve("6/test.txt", 18)))
print("Part one:" + str(solve("6/input.txt", 80)))
print("Part two:" + str(solve("6/input.txt", 256)))
