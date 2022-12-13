extends Node2D

class Cell:
	var value: int
	var cost: int

class Map:
	var data: Array
	var start: Array
	var end: Array
	func _init():
		data = []
		start = [0,0]
		end = [0.0]

var testData = Map.new()
var realData = Map.new()
var key = "SabcdefghijklmnopqrstuvwxyzE"

@onready var puzzle1Button: Button = get_node("Puzzle1Button")
@onready var puzzle2Button: Button = get_node("Puzzle2Button")

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	parse_file('res://../puzzle_input/day12test.txt', testData)
	parse_file('res://../puzzle_input/day12.txt', realData)

func parse_file(filename, map: Map):
	var lines = []
	Utils.load_file_extract_lines(filename, lines)
	for line in lines:
		var newLine = []
		for c in range(line.length()):
			var cell = Cell.new()
			cell.value = key.find(line.substr(c, 1))
			newLine.append(cell)
		map.data.append(newLine)
	# find the start and end
	var start = key.find("S")
	var end = key.find("E")
	for y in range(map.data.size()):
		for x in range(map.data[y].size()):
			if map.data[y][x].value == start:
				map.start = [x,y]
			if map.data[y][x].value == end:
				map.end = [x,y]
	# calculate the cost
	for y in range(map.data.size()):
		for x in range(map.data[y].size()):
			map.data[y][x].cost = 27 - map.data[y][x].value
			var manhattan_dist = abs(y - map.end[1]) + abs(x - map.end[0])
			map.data[y][x].cost += manhattan_dist
			
func _exit_tree():
	pass

func do_puzzle_1(map: Map) -> int:
	var num_moves = 0
	var pos = map.start
	var map_width = map.data[0].size()
	var map_height = map.data.size()
	while pos != map.end:
		var pos_cost = map.data[pos[1]][pos[0]].cost
		var pos_value = map.data[pos[1]][pos[0]].value
		var up_cost = 0
		var down_cost = 0
		var left_cost = 0
		var right_cost = 0
		if pos[0] > 0 and map.data[pos[1]][pos[0]-1].value - pos_value <= 1:
			left_cost = pos_cost - map.data[pos[1]][pos[0]-1].cost
		if pos[0] < map_width - 1 and map.data[pos[1]][pos[0]+1].value - pos_value <= 1:
			right_cost = pos_cost - map.data[pos[1]][pos[0]+1].cost
		if pos[1] > 0 and map.data[pos[1]-1][pos[0]].value - pos_value <= 1:
			up_cost = pos_cost - map.data[pos[1]-1][pos[0]].cost
		if pos[1] < map_height - 1 and map.data[pos[1]+1][pos[0]].value - pos_value <= 1:
			down_cost = pos_cost - map.data[pos[1]+1][pos[0]].cost
		# do move
		
	return num_moves

func _on_puzzle_1_button_pressed():
	do_puzzle_1(testData)

func _on_puzzle_2_button_pressed():
	pass # Replace with function body.
