# part one - answer 1301

numIncremented = 0

# open file
f = open("1/input.txt", "rt")

# read line by line
lines = f.readlines()
prevValue = None

for line in lines:
    value = int(line)
    if prevValue != None:
        if value > prevValue:
            numIncremented = numIncremented + 1

    prevValue = value

# work out if it has goe up since last time

# output
f.close()

print("Part one:" + str(numIncremented))

# part two - answer 1346

f = open("1/input.txt", "rt")

# read line by line
lines = f.readlines()
values = []
prevprev = None
prev = None
value = None

# read values in and sum them
for line in lines:
    prevprev = prev
    prev = value
    value = int(line)

    if prevprev != None:
        values.append(value + prev + prevprev)

numIncremented = 0
prevValue = None
for value in values:
    if prevValue != None:
        if value > prevValue:
            numIncremented = numIncremented + 1
    prevValue = value

print("Part two:" + str(numIncremented))
