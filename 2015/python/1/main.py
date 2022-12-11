f = open("1/input.txt", "rt")

# read line by line
lines = f.readlines()

line = lines[0]

floor = 0
firstBasement = None

for i in range(0, len(line)):
    if line[i] == "(":
        floor += 1
    else:
        floor -= 1
    if (floor < 0) & (firstBasement == None):
        firstBasement = i+1

print("answer 1 - " + str(floor))
print("answer 2 - " + str(firstBasement))