extends Node2D

# Answer 1 -
# Answer 2 -

onready var puzzle1Label: Label = get_node("Puzzle1Label")
onready var puzzle2Label: Label = get_node("Puzzle2Label")

var test1Answer = 21
var test2Answer = 8

var testData = []
var realData = []

# Called when the node enters the scene tree for the first time.
func _ready():
	parse_file(testData, 'res://input/day8test.txt')
	parse_file(realData, 'res://input/day8.txt')

func parse_file(data: Array, filename):
	var lines = []
	Utils.load_file_extract_lines(filename, lines)
	for line in lines:
		var thisRow = []
		for i in range(line.length()):
			thisRow.append(line.substr(i,1))
		data.append(thisRow)

func test_left(data: Array, x: int, y: int) -> bool:
	for i in range(x-1, -1, -1):
		if data[y][i] >= data[y][x]:
			return true
	return false
	
func score_left(data: Array, x: int, y: int) -> int:
	var score = 0
	for i in range(x-1, -1, -1):
		score += 1
		if data[y][i] >= data[y][x]:
			return score
	return score

func test_right(data: Array, x: int, y: int) -> bool:
	for i in range(x+1, data[0].size(), 1):
		if data[y][i] >= data[y][x]:
			return true
	return false

func score_right(data: Array, x: int, y: int) -> int:
	var score = 0
	for i in range(x+1, data[0].size(), 1):
		score += 1
		if data[y][i] >= data[y][x]:
			return score
	return score

func test_up(data: Array, x: int, y: int) -> bool:
	for i in range(y-1, -1, -1):
		if data[i][x] >= data[y][x]:
			return true
	return false

func score_up(data: Array, x: int, y: int) -> int:
	var score = 0
	for i in range(y-1, -1, -1):
		score += 1
		if data[i][x] >= data[y][x]:
			return score
	return score

func test_down(data: Array, x: int, y: int) -> bool:
	for i in range(y+1, data.size(), 1):
		if data[i][x] >= data[y][x]:
			return true
	return false

func score_down(data: Array, x: int, y: int) -> int:
	var score = 0
	for i in range(y+1, data.size(), 1):
		score += 1
		if data[i][x] >= data[y][x]:
			return score
	return score
	
func doPuzzle1(data: Array) -> int:
	var visible = 0
	for y in range(data.size()):
		for x in range(data[0].size()):
			var hidden = test_left(data, x, y) and test_right(data, x, y) and test_up(data, x, y) and test_down(data, x, y)
			if not hidden:
				visible += 1
	return visible

func doPuzzle2(data: Array) -> int:
	var maxScore = 0
	for y in range(1, data.size()-1):
		for x in range(1, data[0].size()-1):
			var score = score_left(data, x, y) * score_right(data, x, y) * score_up(data, x, y) * score_down(data, x, y)
			if score > maxScore:
				maxScore = score
	return maxScore

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Puzzle1Button_pressed():
	if doPuzzle1(testData) == test1Answer:
		puzzle1Label.text = str(doPuzzle1(realData))
	else:
		puzzle1Label.text = "FAIL"

func _on_Puzzle2Button_pressed():
	if doPuzzle2(testData) == test2Answer:
		puzzle2Label.text = str(doPuzzle2(realData))
	else:
		puzzle2Label.text = "FAIL"
