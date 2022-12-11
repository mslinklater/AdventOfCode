f = open("3/input.txt", "rt")

# read line by line
lines = f.readlines()

# step 1 - work out how big the area is

x = 0
y = 0
minX = 0
maxX = 0
minY = 0
maxY = 0

for loc in lines[0]:
    if loc == ">":
        x += 1
    elif loc == "<":
        x -= 1
    elif loc == "^":
        y += 1
    else:
        y -= 1
    minX = min(minX, x)
    maxX = max(maxX, x)
    minY = min(minY, y)
    maxY = max(maxY, y)

xSize = maxX - minX + 1
ySize = maxY - minY + 1

grid = []
for i in range(0, xSize):
    col = []
    for j in range(0, ySize):
        col.append(0)
    grid.append(col)

x = -minX
y = -minY
grid[x][y] += 1
for loc in lines[0]:
    if loc == ">":
        x += 1
    elif loc == "<":
        x -= 1
    elif loc == "^":
        y += 1
    else:
        y -= 1
    grid[x][y] += 1

total = 0

for i in range(0, xSize):
    for j in range(0, ySize):
        if grid[i][j] > 0:
            total += 1

print("Answer 1:" + str(total))

for i in range(0, xSize):
    for j in range(0, ySize):
        grid[i][j] = 0

santaX = -minX
santaY = -minY
grid[santaX][santaY] += 1
roboX = -minX
roboY = -minY
grid[roboX][roboY] += 1
for i in range(0, len(lines[0]), 2):
    if lines[0][i] == ">":
        santaX += 1
    elif lines[0][i] == "<":
        santaX -= 1
    elif lines[0][i] == "^":
        santaY += 1
    else:
        santaY -= 1
    grid[santaX][santaY] += 1

    if lines[0][i+1] == ">":
        roboX += 1
    elif lines[0][i+1] == "<":
        roboX -= 1
    elif lines[0][i+1] == "^":
        roboY += 1
    else:
        roboY -= 1
    grid[roboX][roboY] += 1

total = 0

for i in range(0, xSize):
    for j in range(0, ySize):
        if grid[i][j] > 0:
            total += 1

print("Answer 2:" + str(total))
