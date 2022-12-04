extends Node2D

# puzzle 1 answer - 477
# puzzle 2 answer - 830

var test1Answer = 2
var test2Answer = 4

onready var test1Label: Label = get_node("Test1Label")
onready var test2Label: Label = get_node("Test2Label")
onready var puzzle1Label: Label = get_node("Puzzle1Label")
onready var puzzle2Label: Label = get_node("Puzzle2Label")

var testFirstElfRange = []
var testSecondElfRange = []
var firstElfRange = []
var secondElfRange = []

func _ready():
	parse_input('res://input/day4test.txt', testFirstElfRange, testSecondElfRange)
	parse_input('res://input/day4.txt', firstElfRange, secondElfRange)

func parse_input(filename, first: Array, second: Array):
	var lines = []
	Utils.load_file_extract_lines(filename, lines)
	for line in lines:
		var commaPos = line.find(",")
		first.append(line.substr(0, commaPos))
		second.append(line.substr(commaPos+1, line.length() - commaPos - 1))

func doPuzzle1(first: Array, second: Array) -> int:
	var result = 0
	for i in range(first.size()):
		var dashPos = first[i].find("-")
		var min1 = int(first[i].substr(0, dashPos))
		var max1 = int(first[i].substr(dashPos+1))
		dashPos = second[i].find("-")
		var min2 = int(second[i].substr(0, dashPos))
		var max2 = int(second[i].substr(dashPos+1))
		if (min1 >= min2 and max1 <= max2) or (min2 >= min1 and max2 <= max1):
			result += 1			
	return result

func doPuzzle2(first: Array, second: Array) -> int:
	var result = 0
	for i in range(first.size()):
		var dashPos = first[i].find("-")
		var min1 = int(first[i].substr(0, dashPos))
		var max1 = int(first[i].substr(dashPos+1))
		dashPos = second[i].find("-")
		var min2 = int(second[i].substr(0, dashPos))
		var max2 = int(second[i].substr(dashPos+1))
		if max1 >= min2 and max1 <= max2:
			result += 1
		elif min1 >= min2 and min1 <= max2:
			result += 1
		elif max2 >= min1 and max2 <= max1:
			result += 1
		elif min2 >= min1 and min2 <= max1:
			result += 1
	return result

# UI responders

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Test1Button_pressed():
	if doPuzzle1(testFirstElfRange, testSecondElfRange) == test1Answer:
		test1Label.text = "PASS"
	else:
		test1Label.text = "FAIL"

func _on_Puzzle1Button_pressed():
	puzzle1Label.text = str(doPuzzle1(firstElfRange, secondElfRange))

func _on_Test2Button_pressed():
	if doPuzzle2(testFirstElfRange, testSecondElfRange) == test2Answer:
		test2Label.text = "PASS"
	else:
		test2Label.text = "FAIL"

func _on_Puzzle2Button_pressed():
	puzzle2Label.text = str(doPuzzle2(firstElfRange, secondElfRange))
