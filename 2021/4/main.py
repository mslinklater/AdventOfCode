# Advent of Code 2021 - day 4

class Board:
    def __init__(self):
        self.numbers = []
        self.state = []
        self.hasBingo = False

    def add_line(self, line):
        newLine = line.split(" ")
        for num in newLine:
            if len(num) > 0:
                self.numbers.append(int(num))
                self.state.append(False)

    def called(self, num):
        for i in range(0, len(self.numbers)):
            if self.numbers[i] == num:
                self.state[i] = True

    def sum_of_unmarked(self):
        sum = 0
        for i in range(0, len(self.state)):
            if self.state[i] == False:
                sum += self.numbers[i]
        return sum

    def bingo(self):
        if self.hasBingo:
            return False
        # check rows
        for row in range(0, 5):
            bingo = True
            for col in range(0, 5):
                bingo &= self.state[row*5 + col]
            if bingo:
                self.hasBingo = True
                return True
        # check columns
        for col in range(0, 5):
            bingo = True
            for row in range(0, 5):
                bingo &= self.state[row*5 + col]
            if bingo:
                self.hasBingo = True
                return True
        return False

# read line by line
f = open("4/input.txt", "rt")
lines = f.readlines()
numLines = len(lines)

# read in the numbers
theNumbers = lines[0].split(",")
numNumbers = len(theNumbers)

# build the boards
boards = []
currentLine = 2
while(currentLine < numLines):
    newBoard = Board()
    for i in range(0,5):
        newBoard.add_line(lines[currentLine+i])
    boards.append(newBoard)
    currentLine += 6

# Puzzle 1 - answer 28082
# Puzzle 2 - answer 8224

boardCount = 0

for num in theNumbers:
    for board in boards:
        board.called(int(num))

    for board in boards:
        if board.bingo():
            if boardCount == 0:
                print("answer 1 - " + str(board.sum_of_unmarked() * int(num)))
            elif boardCount == len(boards)-1:
                print("answer 2 - " + str(board.sum_of_unmarked() * int(num)))
                break
            boardCount += 1

f.close()
