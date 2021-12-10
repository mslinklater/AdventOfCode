# Advent of code 2021 - day 9
# https://adventofcode.com/2021/day/9

UNKNOWN = 1
UP = 2
DOWN = 3
LEFT = 4
RIGHT = 5
BOTTOM = 6
TOP = 7

class Cell:
    def __init__(self):
        self.value = -1
        self.kind = UNKNOWN
        self.basin = None

def solve(filename, part):
    f = open(filename, "rt")
    readLines = f.readlines()

    inputLines = []
    for line in readLines:
        inputLines.append(line.strip("\n"))

    map = []
    ySize = len(inputLines)
    xSize = len(inputLines[0])
    for x in range(0, xSize):
        col = []
        for y in range(0, ySize):
            newCell = Cell()
            col.append(newCell)
        map.append(col)
    
    y = 0
    for line in inputLines:
        x = 0
        for digit in line:
            map[x][y].value = int(digit)
            x += 1
        y += 1

    total = 0
    lowPoints = []

    for x in range(0, xSize):
        for y in range(0, ySize):
            thisHeight = map[x][y].value
            lowest = True
            if x > 0 and map[x-1][y].value <= thisHeight:
                lowest = False
            if x < xSize-1 and map[x+1][y].value <= thisHeight:
                lowest = False
            if y > 0 and map[x][y-1].value <= thisHeight:
                lowest = False
            if y < ySize-1 and map[x][y+1].value <= thisHeight:
                lowest = False
            if lowest:
                total += thisHeight + 1
                lowPoints.append([x,y])
                map[x][y].kind = BOTTOM

    if part == 1:
        return total

    # Now work out basins
    unknownQueue = []
    for 


print("Test 1:" + str(solve("9/test.txt", 1)))
print("Part 1:" + str(solve("9/input.txt", 1)))
