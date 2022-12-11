extends Node2D

var test1Answer = 7
var test2Answer = 5
var test3Answer = 6
var test4Answer = 10
var test5Answer = 11

var test1Answer2 = 19
var test2Answer2 = 23
var test3Answer2 = 23
var test4Answer2 = 29
var test5Answer2 = 26

@onready var puzzle1Label: Label = get_node("Puzzle1Label")
@onready var puzzle2Label: Label = get_node("Puzzle2Label")

var test1Data: String
var test2Data: String
var test3Data: String
var test4Data: String
var test5Data: String
var data: String

# Called when the node enters the scene tree for the first time.
func _ready():
	test1Data = parse_input('res://../puzzle_input/day6test1.txt')
	test2Data = parse_input('res://../puzzle_input/day6test2.txt')
	test3Data = parse_input('res://../puzzle_input/day6test3.txt')
	test4Data = parse_input('res://../puzzle_input/day6test4.txt')
	test5Data = parse_input('res://../puzzle_input/day6test5.txt')
	data = parse_input('res://../puzzle_input/day6.txt')

func parse_input(filename) -> String:
	var f = FileAccess.open(filename, FileAccess.READ)
	var ret = f.get_line()
	return ret

# UI Responders

func _on_MainMenuButton_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func doTask(inputData: String, num) -> int:
	for i in range(0, inputData.length()-4):
		var c = []
		for j in range(num):
			c.append(inputData.substr(i+j, 1))

		var dupe = false
		for x in range(num):
			for y in range(x+1, num):
				if c[x] == c[y]:
					dupe = true
		if dupe == false:
			return i+num
	return -1

func _on_Puzzle1Button_pressed():
	if doTask(test1Data, 4) != test1Answer:
		puzzle1Label.text = "FAIL 1"
	elif doTask(test2Data, 4) != test2Answer:
		puzzle1Label.text = "FAIL 2"
	elif doTask(test3Data, 4) != test3Answer:
		puzzle1Label.text = "FAIL 3"
	elif doTask(test4Data, 4) != test4Answer:
		puzzle1Label.text = "FAIL 4"
	elif doTask(test5Data, 4) != test5Answer:
		puzzle1Label.text = "FAIL 5"
	else:
		puzzle1Label.text = str(doTask(data, 4))

func _on_Puzzle2Button_pressed():
	if doTask(test1Data, 14) != test1Answer2:
		puzzle2Label.text = "FAIL 1"
	elif doTask(test2Data, 14) != test2Answer2:
		puzzle2Label.text = "FAIL 2"
	elif doTask(test3Data, 14) != test3Answer2:
		puzzle2Label.text = "FAIL 3"
	elif doTask(test4Data, 14) != test4Answer2:
		puzzle2Label.text = "FAIL 4"
	elif doTask(test5Data, 14) != test5Answer2:
		puzzle2Label.text = "FAIL 5"
	else:
		puzzle2Label.text = str(doTask(data, 14))
