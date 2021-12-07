# Advent of Code 2021 - day 5

class Line:
    def __init__(self):
        self.x1 = None
        self.y1 = None
        self.x2 = None
        self.y2 = None
        self.minY = None
        self.maxY = None
        self.minX = None
        self.maxX = None

    def parse(self, line):
        sides = line.split(" -> ")
        left = sides[0].split(",")
        self.x1 = int(left[0])
        self.y1 = int(left[1])
        right = sides[1].split(",")
        self.x2 = int(right[0])
        self.y2 = int(right[1])
        self.minX = min(self.x1, self.x2)
        self.maxX = max(self.x1, self.x2)
        self.minY = min(self.y1, self.y2)
        self.maxY = max(self.y1, self.y2)
    
    def max(self):
        return max(self.x1, self.x2), max(self.y1, self.y2)

    def is_horizontal(self):
        return self.y1 == self.y2

    def is_vertical(self):
        return self.x1 == self.x2

    def is_diagonal(self):
        return self.maxX - self.minX == self.maxY - self.minY
    
    def positive_gradient(self):
        diffY = self.y1-self.y2
        diffX = self.x1-self.x2
        gradient = diffY / diffX
        return gradient > 0

f = open("5/input.txt", "rt")
inputLines = f.readlines()

lines = []

for inputLine in inputLines:
    newLine = Line()
    newLine.parse(inputLine)
    lines.append(newLine)

# find the size of the area and set up the grid

maxX = 0
maxY = 0
for line in lines:
    newX, newY = line.max()
    maxX = max(maxX, newX)
    maxY = max(maxY, newY)

sizeX = maxX + 1
sizeY = maxY + 1

grid = []
for x in range(0,sizeX):
    gridColumn = []
    for y in range(0, sizeY):
        gridColumn.append(0)
    grid.append(gridColumn.copy())

# answer 1

for line in lines:
    if line.is_vertical():
        for i in range(line.minY, line.maxY+1):
            grid[line.x1][i] += 1
    elif line.is_horizontal():
        for i in range(line.minX, line.maxX+1):
            grid[i][line.y1] += 1

sum = 0
for x in range(0, sizeX):
    for y in range(0, sizeY):
        if grid[x][y] > 1:
            sum += 1

print("answer 1 - " + str(sum))

# answer 2
for line in lines:
    if line.is_diagonal():
        if line.positive_gradient():
            for i in range(0, (line.maxX-line.minX)+1):
                grid[line.minX+i][line.minY+i] += 1
        else:
            for i in range(0, (line.maxX-line.minX)+1):
                grid[line.minX+i][line.maxY-i] += 1

sum = 0
for x in range(0, sizeX):
    for y in range(0, sizeY):
        if grid[x][y] > 1:
            sum += 1

print("answer 2 - " + str(sum))
