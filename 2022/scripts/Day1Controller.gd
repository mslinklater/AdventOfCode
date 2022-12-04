extends Node2D

# Answer 1 = 69795
# Answer 1 = 208437

onready var puzzle1AnswerLabel: Label = get_node("Puzzle1AnswerLabel")
onready var puzzle2AnswerLabel: Label = get_node("Puzzle2AnswerLabel")
onready var test1ResultLabel: Label = get_node("Test1Result")
onready var test2ResultLabel: Label = get_node("Test2Result")

onready var progressBar: ProgressBar = get_node("ProgressBar")

var test1Answer = 24000
var test2Answer = 45000

var testLines = []
var testTotals = []
var lines = []
var totals = []

var processing = false
var processingProgress = 0
var currentlyExecuting = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Utils.load_file_extract_lines('res://input/day1test.txt', testLines)
	Utils.load_file_extract_lines('res://input/day1.txt', lines)
	parse_lines(testLines, testTotals)
	parse_lines(lines, totals)
	progressBar.percent_visible = 0

func _update():
	if currentlyExecuting != 0:
		currentlyExecuting.resume()

func set_processing_state(_input: bool):
	processing = _input
	if processing:
		processingProgress = 0
	else:
		pass

func parse_lines(input: Array, output: Array):
	output.clear()
	var thisTotal = 0
	for line in input:
		if line.length() > 0:
			thisTotal += int(line)
		else:
			output.append(thisTotal)
			thisTotal = 0

func doPart1(data: Array) -> int:
	var largest: int = 0
	for val in data:
		if val > largest:
			largest = val
#		yield()
	return largest

func doPart2(data: Array) -> int:
	var sortedTotals = data
	sortedTotals.sort()
	var topThreeTotal = sortedTotals[sortedTotals.size()-1] + sortedTotals[sortedTotals.size()-2] + sortedTotals[sortedTotals.size()-3]
	return topThreeTotal

# Button handlers

func _on_Mainmenu_Button_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Puzzle1Button_pressed():
	puzzle1AnswerLabel.text = str(doPart1(totals))

func _on_Puzzle2Button_pressed():
	puzzle2AnswerLabel.text = str(doPart2((totals)))

func _on_Test1_pressed():
#	set_processing_state(true)
#	currentlyExecuting = doPart1(testTotals)
	if doPart1(testTotals) == test1Answer:
		test1ResultLabel.text = "PASS"
	else:
		test1ResultLabel.text = "FAIL"

func _on_Test2_pressed():
	if doPart2(testTotals) == test2Answer:
		test2ResultLabel.text = "PASS"
	else:
		test2ResultLabel.text = "FAIL"
