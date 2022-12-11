# Advent of code 2021 - day 10
# https://adventofcode.com/2021/day/10

def solve(filename, part):
    map = []
    f = open(filename, "rt")
    readLines = f.readlines()

    input = []
    openBraces = "{[(<"
    closeBraces = "}])>"
    for readLine in readLines:
        input.append(readLine.strip("\n"))

    completeLines = []
    incompleteLines = []
    corruptedLines = []
    corruptedPositions = []
    completionScores = []

    ret = 0

    for line in input:
        stack = []
        lineLength = len(line)
        i = 0
        abortLine = False
        corrupted = False
        while i < lineLength and abortLine == False:
            c = line[i]
            if openBraces.find(c) == -1:
                # close
                topOfStack = stack.pop(len(stack)-1)
                if openBraces.find(topOfStack) != closeBraces.find(c):
                    # not matching
                    corruptedLines.append(line)
                    corruptedPositions.append(i)
                    if part == 1:
                        if c == ")":
                            ret += 3
                        elif c == "]":
                            ret += 57
                        elif c == "}":
                            ret += 1197
                        else:
                            ret += 25137
                    abortLine = True
                    corrupted = True
            else:
                # open
                stack.append(c)
            i += 1

        # line has finished
        if corrupted == False:
            if len(stack) == 0:
                completeLines.append(line)
            else:
                incompleteLines.append(line)
                completion = []
                while len(stack) > 0:
                    c = stack.pop(len(stack)-1)
                    completion.append(closeBraces[openBraces.find(c)])
                score = 0
                for i in range(0, len(completion)):
                    score *= 5
                    c = completion[i]
                    if c == ")":
                        score += 1
                    elif c == "]":
                        score += 2
                    elif c == "}":
                        score += 3
                    else:
                        score += 4
                completionScores.append(score)

    if part == 2:
        sortedCompletions = sorted(completionScores)
        middle = len(sortedCompletions)/2
        ret = sortedCompletions[int(middle)]

    return ret

print("Test:" + str(solve("10/test.txt", 1)))
print("Puzzle A:" + str(solve("10/input.txt", 1)))
print("Puzzle B:" + str(solve("10/input.txt", 2)))
