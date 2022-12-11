extends Node2D

var test1Answer = "CMZ"
var test2Answer = "MCD"

# puzzle 1 - VGBBJCRMN
# puzzle 2 - LBBVJBRMH

@onready var test1Label: Label = get_node("Test1Label")
@onready var test2Label: Label = get_node("Test2Label")
@onready var puzzle1Label: Label = get_node("Puzzle1Label")
@onready var puzzle2Label: Label = get_node("Puzzle2Label")

class StartingState:
	var startstacks: Array
	var stacks: Array
	var move_count: Array
	var move_src: Array
	var move_dest: Array
	
@onready var testData := StartingState.new()
@onready var data := StartingState.new()

func _ready():
	parse_input('res://input/day5test.txt', testData)
	parse_input('res://input/day5.txt', data)

func parse_input(filename, state: StartingState):
	var lines = []
	Utils.load_file_extract_lines(filename, lines)	
	# parse initial state
	var blankLine = 0
	for i in range(lines.size()):
		if lines[i].length() == 0:
			blankLine = i
			break
	var numberLine = blankLine - 1
	var numStacks = 0
	var testStacks = 1
	while lines[numberLine].find(str(testStacks)) != -1:
		numStacks += 1
		testStacks += 1
	# set up empty stacks - array of strings
	state.startstacks = []
	for i in range(numStacks):
		state.startstacks.append("")
	# fill stacks with contents
	for i in range(blankLine-1, 0, -1):
		var thisLine = lines[i-1]
		for stack in range(numStacks):
			var actualCol = 1 + (stack*4)
			if thisLine.length() > actualCol:
				var c = thisLine.substr(actualCol, 1)
				if c != " ":
					state.startstacks[stack] += c
	# parse moves
	for i in range(blankLine+1, lines.size(), 1):
		var thisLine = lines[i]
		var arr = thisLine.split(" ", true, 6)
		state.move_count.append(int(arr[1]))
		state.move_src.append(int(arr[3]))
		state.move_dest.append(int(arr[5]))

func doTask(state: StartingState, which) -> String:
	var result = ""
	state.stacks = state.startstacks.duplicate(true)
	for i in range(state.move_count.size()):
		var count = state.move_count[i]
		var src = state.move_src[i] - 1
		var dest = state.move_dest[i] - 1
		if which == 1:
			for j in range(count):
				var c = state.stacks[src].substr(state.stacks[src].length()-1)
				state.stacks[src] = state.stacks[src].left(state.stacks[src].length() - 1)
				state.stacks[dest] += c
		else:
			var c = state.stacks[src].substr(state.stacks[src].length()-count)
			state.stacks[src] = state.stacks[src].left(state.stacks[src].length() - count)
			state.stacks[dest] += c
	for col in range(state.stacks.size()):
		result += state.stacks[col].right(state.stacks[col].length() - 1)
	return result

func _on_MainMenuButton_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_Puzzle1Button_pressed():
	if doTask(testData, 1) == test1Answer:
		puzzle1Label.text = str(doTask(data, 1))
	else:
		puzzle1Label.text = "FAIL"

func _on_Puzzle2Button_pressed():
	if doTask(testData, 2) == test2Answer:
		puzzle2Label.text = str(doTask(data, 2))
	else:
		puzzle2Label.text = "FAIL"
