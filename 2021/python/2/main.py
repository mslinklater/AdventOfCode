# part one - answer 1762050

numIncremented = 0

# open file
f = open("2/input.txt", "rt")

# read line by line
lines = f.readlines()

horizPos = 0
depth = 0

for line in lines:
    elements = line.split(" ")
    if elements[0] == "forward":
        horizPos += int(elements[1])
    elif elements[0] == "down":
        depth += int(elements[1])
    else:
        depth -= int(elements[1])

print("Answer 1:" + str(horizPos * depth))

# part 2 - answer 1855892637

horizPos = 0
depth = 0
aim = 0

for line in lines:
    elements = line.split(" ")
    if elements[0] == "forward":
        fwd = int(elements[1])
        horizPos += fwd
        depth += aim * fwd
    elif elements[0] == "down":
        aim += int(elements[1])
    else:
        aim -= int(elements[1])

print("Answer 2:" + str(horizPos * depth))
