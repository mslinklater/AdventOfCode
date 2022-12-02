extends Node2D

# Answer 1 = 69795
# Answer 1 = 208437

onready var puzzle1AnswerLabel: Label = get_node("Puzzle1AnswerLabel")
onready var puzzle2AnswerLabel: Label = get_node("Puzzle2AnswerLabel")
onready var test1ResultLabel: Label = get_node("Test1Result")
onready var test2ResultLabel: Label = get_node("Test2Result")

var test1Answer = 24000
var test2Answer = 45000

var testTotals = []
var totals = []

# Called when the node enters the scene tree for the first time.
func _ready():
	parse_file('res://input/day1test.txt', testTotals)
	parse_file('res://input/day1.txt', totals)

func parse_file(filename, dest: Array):
	var f = File.new()
	f.open(filename, File.READ)
	var thisTotal = 0
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		if line.length() > 0:
			thisTotal += int(line)
		else:
			dest.append(thisTotal)
			thisTotal = 0
	f.close()

func doPart1(data: Array) -> int:
	var largest: int = 0
	for val in data:
		if val > largest:
			largest = val
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
	if doPart1(testTotals) == test1Answer:
		test1ResultLabel.text = "PASS"
	else:
		test1ResultLabel.text = "FAIL"

func _on_Test2_pressed():
	if doPart2(testTotals) == test2Answer:
		test2ResultLabel.text = "PASS"
	else:
		test2ResultLabel.text = "FAIL"
