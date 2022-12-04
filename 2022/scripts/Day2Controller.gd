extends Node2D

# answer 1 = 12679
# answer 2 = 14470

onready var test1Answer = 15
onready var test2Answer = 12

const rockScore = 1
const paperScore = 2
const scissorsScore = 3

const loseScore = 0
const drawScore = 3
const winScore = 6

onready var puzzle1AnswerLabel: Label = get_node("Puzzle1ResultLabel")
onready var puzzle2AnswerLabel: Label = get_node("Puzzle2ResultLabel")
onready var test1ResultLabel: Label = get_node("Test1ResultLabel")
onready var test2ResultLabel: Label = get_node("Test2ResultLabel")

var testLines = []
var testFirstMoves = []
var testSecondMoves = []
var testRequiredResult = []

var lines = []
var firstMoves = []
var secondMoves = []
var requiredResult = []

enum Move {ROCK, PAPER, SCISSORS}
enum Result {LOSE, DRAW, WIN}

# Called when the node enters the scene tree for the first time.
func _ready():
	Utils.load_file_extract_lines('res://input/day2test.txt', testLines)
	Utils.load_file_extract_lines('res://input/day2.txt', lines)
	parse_moves(testLines, testFirstMoves, testSecondMoves, testRequiredResult)
	parse_moves(lines, firstMoves, secondMoves, requiredResult)

func parse_moves(input: Array, first: Array, second: Array, result: Array):
	for line in input:
		if line.length() > 0:
			match line[0]:
				"A":
					first.append(Move.ROCK)
				"B":
					first.append(Move.PAPER)
				"C":
					first.append(Move.SCISSORS)
			match line[2]:
				"X":
					second.append(Move.ROCK)
					result.append(Result.LOSE)
				"Y":
					second.append(Move.PAPER)
					result.append(Result.DRAW)
				"Z":
					second.append(Move.SCISSORS)
					result.append(Result.WIN)

func doPart1(first: Array, second:Array) -> int:
	var score = 0
	for i in range(first.size()):
		match second[i]:
			Move.ROCK:
				score += rockScore
			Move.PAPER:
				score += paperScore
			Move.SCISSORS:
				score += scissorsScore
		match first[i]:
			Move.ROCK:
				match second[i]:
					Move.ROCK:
						score += drawScore
					Move.PAPER:
						score += winScore
					Move.SCISSORS:
						score += loseScore
			Move.PAPER:
				match second[i]:
					Move.ROCK:
						score += loseScore
					Move.PAPER:
						score += drawScore
					Move.SCISSORS:
						score += winScore
			Move.SCISSORS:
				match second[i]:
					Move.ROCK:
						score += winScore
					Move.PAPER:
						score += loseScore
					Move.SCISSORS:
						score += drawScore
	return score

func doPart2(first: Array, result:Array) -> int:
	var score = 0
	for i in range(first.size()):
		match result[i]:
			Result.LOSE:
				score += loseScore
			Result.DRAW:
				score += drawScore
			Result.WIN:
				score += winScore
		match first[i]:
			Move.ROCK:
				match result[i]:
					Result.LOSE:
						# scissors
						score += scissorsScore
					Result.DRAW:
						# rock
						score += rockScore
					Result.WIN:
						# paper
						score += paperScore
			Move.PAPER:
				match result[i]:
					Result.LOSE:
						# rock
						score += rockScore
					Result.DRAW:
						# paper
						score += paperScore
					Result.WIN:
						# scissors
						score += scissorsScore
			Move.SCISSORS:
				match result[i]:
					Result.LOSE:
						# paper
						score += paperScore
					Result.DRAW:
						# scissors
						score += scissorsScore
					Result.WIN:
						# rock
						score += rockScore
	return score
						
# UI handlers

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_Test1Button_pressed():
	if doPart1(testFirstMoves, testSecondMoves) == test1Answer:
		test1ResultLabel.text = "PASS"
	else:
		test1ResultLabel.text = "FAIL"
		
func _on_Puzzle1Button_pressed():
	puzzle1AnswerLabel.text = str(doPart1(firstMoves, secondMoves))


func _on_Test2Button_pressed():
	if doPart2(testFirstMoves, testRequiredResult) == test2Answer:
		test2ResultLabel.text = "PASS"
	else:
		test2ResultLabel.text = "FAIL"


func _on_Puzzle2Button_pressed():
	puzzle2AnswerLabel.text = str(doPart2(firstMoves, requiredResult))
