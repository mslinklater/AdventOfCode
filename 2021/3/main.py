# Advent of code 2021 - day 3

f = open("3/input.txt", "rt")

# read line by line
lines = f.readlines()
numLines = len(lines)

numColumns = len(lines[0])-1
mostCommon = []

def get_counts(array, col):
    oneCount = 0
    zeroCount = 0
    for entry in array:
        if entry[col] == '1':
            oneCount+=1
        else:
            zeroCount+=1
    return zeroCount, oneCount

def get_digit(array, col):
    zeroCount, oneCount = get_counts(array, col)
    if zeroCount > oneCount:
        return '0'
    else:
        return '1'

# part 1 - answer 4160394
gamma = 0
epsilon = 0

for col in range(0,numColumns):
    zeroCount, oneCount = get_counts(lines, col)
    newDigit = 0

    if oneCount > zeroCount:
        newDigit = 1
        mostCommon.append("1")
    else:
        mostCommon.append("0")

    gamma = (gamma << 1) + newDigit
    epsilon = (epsilon << 1) + (1-newDigit)

print("Answer 1:" + str(gamma * epsilon))

# part 2 - answer 4125600

# find oxygen rating
workingSet = lines.copy()
digitIndex = 0
while len(workingSet) > 1:
    desiredDigit = get_digit(workingSet, digitIndex)

    tempArray = []
    for line in workingSet:
        if line[digitIndex] == desiredDigit:
            tempArray.append(line)
    digitIndex+=1
    workingSet = tempArray.copy()
oxygenRating = int(workingSet[0],2)

# now find scrubber rating
workingSet = lines.copy()
digitIndex = 0
while len(workingSet) > 1:
    desiredDigit = get_digit(workingSet, digitIndex)

    tempArray = []
    for line in workingSet:
        if line[digitIndex] != desiredDigit:
            tempArray.append(line)
    digitIndex+=1
    workingSet = tempArray.copy()
scrubberRating = int(workingSet[0],2)

print("Answer 2:" + str(oxygenRating * scrubberRating))
