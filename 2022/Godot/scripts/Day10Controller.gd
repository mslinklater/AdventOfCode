extends Node2D

# Answer 1 -
# Answer 2 - 

var test60Value = 1140
var test100Value = 1800
var test140Value = 2940
var test180Value = 2880
var test220Value = 3960
var test1Value = 13140
var test2Value = 0

var testData = []
var realData = []

@onready var puzzle1Label: Label = get_node("Puzzle1Label")
@onready var puzzle2Label: Label = get_node("Puzzle2Label")
@onready var puzzle2TextEdit: TextEdit = get_node("Puzzle2TextEdit")

# Called when the node enters the scene tree for the first time.
func _ready():
	parse_file('res://input/day10test.txt', testData)
	parse_file('res://input/day10.txt', realData)

func parse_file(filename, data: Array):
	var lines = []
	Utils.load_file_extract_lines(filename, lines)
	var sig = 1
	for line in lines:
		if line == "noop":
			data.append(sig)
		else:
			var inc = int(line.split(" ")[1])
			data.append(sig)
			data.append(sig)
			sig += inc

func doPuzzle1(data: Array) -> int:
	return data[19] * 20 + data[59] * 60 + data[99] * 100 + data[139] * 140 + data[179] * 180 + data[219] * 220

func doPuzzle2(data: Array):
	for row in range(6):
		var line = ""
		for col in range(40):
			var i = row * 40
			var diff = data[i+col] - col
			if diff > -2 and diff < 2:
				line = line + "X"
			else:
				line = line + "."
		print(line)

func _on_MainMenuButton_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_Puzzle1Button_pressed():
	if testData[59] * 60 != test60Value:
		puzzle1Label.text = "FAIL1"
	elif testData[99] * 100 != test100Value:
		puzzle1Label.text = "FAIL2"
	elif testData[139] * 140 != test140Value:
		puzzle1Label.text = "FAIL3"
	elif testData[179] * 180 != test180Value:
		puzzle1Label.text = "FAIL4"
	elif testData[219] * 220 != test220Value:
		puzzle1Label.text = "FAIL5"
	else:
		puzzle1Label.text = str(doPuzzle1(realData))

func _on_Puzzle2Button_pressed():
	doPuzzle2(testData)
	print(" ")
	doPuzzle2(realData)
