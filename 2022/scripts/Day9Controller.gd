extends Node2D

# Answer 1 - 6406
# Answer 2 - 

onready var puzzle1Label: Label = get_node("Puzzle1Label")
onready var puzzle2Label: Label = get_node("Puzzle2Label")

var test1Answer = 13
var test2Answer = 36

enum Direction {UP, DOWN, LEFT, RIGHT}

var moveSet = [
	[[1,1],		[1,1],		[0,1],		[-1,1],		[-1,1]],
	[[1,1],		[0,0],		[0,0],		[0,0],		[-1,1]],
	[[1,0],		[0,0],		[0,0],		[0,0],		[-1,0]],
	[[1,-1],	[0,0],		[0,0],		[0,0],		[-1,-1]],
	[[1,-1],	[1,-1],		[0,-1],		[-1,-1],	[-1,-1]]
]

class Move:
	var direction
	var count: int

var testData = []
var test2Data = []
var realData = []

func _ready():
	parse_file(testData, 'res://input/day9test.txt')
	parse_file(test2Data, 'res://input/day9test2.txt')
	parse_file(realData, 'res://input/day9.txt')

func parse_file(data: Array, filename):
	var lines = []
	Utils.load_file_extract_lines(filename, lines)
	for line in lines:
		var parts = line.split(" ")
		var move = Move.new()
		match parts[0]:
			"U":
				move.direction = Direction.UP
			"D":
				move.direction = Direction.DOWN
			"L":
				move.direction = Direction.LEFT
			"R":
				move.direction = Direction.RIGHT
		move.count = int(parts[1])
		data.append(move)

func follow(head: Array, tail: Array):
	var thisMove = moveSet[tail[1]-head[1]+2][tail[0]-head[0]+2]
	tail[0] += thisMove[0]
	tail[1] += thisMove[1]

func doPuzzle1(data: Array) -> int:
	var head = [0,0]
	var tail = [0,0]
	var map = {"0,0": true}
	for move in data:
		match move.direction:
			Direction.UP:
				for i in range(move.count):
					head[1] -= 1
					follow(head, tail)
					map[str(tail[0])+","+str(tail[1])] = true
			Direction.DOWN:
				for i in range(move.count):
					head[1] += 1
					follow(head, tail)
					map[str(tail[0])+","+str(tail[1])] = true
			Direction.LEFT:
				for i in range(move.count):
					head[0] -= 1
					follow(head, tail)
					map[str(tail[0])+","+str(tail[1])] = true
			Direction.RIGHT:
				for i in range(move.count):
					head[0] += 1
					follow(head, tail)
					map[str(tail[0])+","+str(tail[1])] = true
	return map.size()

func doPuzzle2(data: Array) -> int:
	var rope = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
	var map = {"0,0": true}
	for move in data:
		match move.direction:
			Direction.UP:
				for i in range(move.count):
					rope[0][1] -= 1
					for sec in range(rope.size()-1):
						follow(rope[sec], rope[sec+1])
					map[str(rope[9][0])+","+str(rope[9][1])] = true
			Direction.DOWN:
				for i in range(move.count):
					rope[0][1] += 1
					for sec in range(rope.size()-1):
						follow(rope[sec], rope[sec+1])
					map[str(rope[9][0])+","+str(rope[9][1])] = true
			Direction.LEFT:
				for i in range(move.count):
					rope[0][0] -= 1
					for sec in range(rope.size()-1):
						follow(rope[sec], rope[sec+1])
					map[str(rope[9][0])+","+str(rope[9][1])] = true
			Direction.RIGHT:
				for i in range(move.count):
					rope[0][0] += 1
					for sec in range(rope.size()-1):
						follow(rope[sec], rope[sec+1])
					map[str(rope[9][0])+","+str(rope[9][1])] = true
	return map.size()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Puzzle1Button_pressed():
	if doPuzzle1(testData) == test1Answer:
		puzzle1Label.text = str(doPuzzle1(realData))
	else:
		puzzle1Label.text = "FAIL"


func _on_Puzzle2Button_pressed():
	if doPuzzle2(test2Data) == test2Answer:
		puzzle2Label.text = str(doPuzzle2(realData))
	else:
		puzzle2Label.text = "FAIL"
