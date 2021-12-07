# Advent of code 2021 - day 7
# https://adventofcode.com/2021/day/7

def solve(filename, part):

    f = open(filename, "rt")
    inputLines = f.readlines()

    positions = []

    minPos = 0
    maxPos = 0
    startPositions = inputLines[0].split(",")
    for pos in startPositions:
        intPos = int(pos)
        minPos = min(minPos, intPos)
        maxPos = max(maxPos, intPos)
        positions.append(intPos)

    if part == 0:
        lowestFuel = 999999
        lowestFuelPos = None
        for i in range(minPos, maxPos+1):
            total = 0
            for pos in positions:
                total += abs(pos - i)
            if total < lowestFuel:
                lowestFuel = total
                lowestFuelPos = i

        return lowestFuel
    else:
        lowestFuel = 999999999999
        lowestFuelPos = None
        for i in range(minPos, maxPos+1):
            total = 0
            for pos in positions:
                distance = abs(pos - i)
                total += (distance * (distance + 1)) / 2
            if total < lowestFuel:
                lowestFuel = total
                lowestFuelPos = i

        return lowestFuel

print("Test:" + str(solve("7/test.txt", 0)))
print("Part a:" + str(solve("7/input.txt", 0)))
print("Part b:" + str(solve("7/input.txt", 1)))
