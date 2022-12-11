extends Node2D

# Puzzle 1 answer - 7746
# Puzzle 2 answer - 2604

var test1Answer = 157
var test2Answer = 70

@onready var test1Label: Label = get_node("Test1Label")
@onready var test2Label: Label = get_node("Test2Label")
@onready var puzzle1Label: Label = get_node("Puzzle1Label")
@onready var puzzle2Label: Label = get_node("Puzzle2Label")

var testPouch1 = []
var pouch1 = []
var testPouch2 = []
var pouch2 = []

# Called when the node enters the scene tree for the first time.
func _ready():
	parse_data('res://input/day3test.txt', testPouch1, testPouch2)
	parse_data('res://input/day3.txt', pouch1, pouch2)

func parse_data(filename, p1: Array, p2: Array):
	var lines = []
	Utils.load_file_extract_lines(filename, lines)
	for line in lines:
		var size = line.length()
		var leftLine = line.substr(0, size/2)
		var rightLine = line.substr(size/2, size/2)
		p1.append(leftLine)
		p2.append(rightLine)

func score_for_letter(letter) -> int:
	if letter >= 'a' and letter <= 'z':
		return letter.unicode_at(0) - "a".unicode_at(0) + 1
	else:
		return letter.unicode_at(0) - "A".unicode_at(0) + 27

func doPuzzle1(p1: Array, p2: Array) -> int:
	var total = 0
	
	for row in range(p1.size()):
		# split input in to two arrays
		var left = p1[row]
		var right = p2[row]
		if left.length() > 0 and right.length() > 0:
			var leftLetters = []
			var rightLetters = []
			
			for i in range(left.length()):
				leftLetters.append(left.substr(i, 1))
				rightLetters.append(right.substr(i, 1))
			
			var copy = ""
			
			for first in leftLetters:
				for second in rightLetters:
					if first == second:
						copy = first;

			total += score_for_letter(copy)
			
	return total
	
func create_set(x: String) -> Array:
	var ret = []
	for i in range(x.length()):
		var c = x.substr(i,1)
		if not ret.has(c):
			ret.append(c)
	return ret
	
func intersect(x: Array, y: Array) -> Array:
	var ret = []
	for item in y:
		if x.has(item):
			ret.append(item)
	return ret

func doPuzzle2(p1: Array, p2: Array) -> int:
	var i = 0
	var total = 0
	while i < p1.size()-2:
		var bag1 = create_set(p1[i] + p2[i])
		var bag2 = create_set(p1[i+1] + p2[i+1])
		var bag3 = create_set(p1[i+2] + p2[i+2])
		bag1 = intersect(bag1, bag2)
		bag1 = intersect(bag1, bag3)
		assert(bag1.size() == 1)
		total += score_for_letter(bag1[0])
		i += 3
	return total
		
# UI responders

func _on_MainMenuButton_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_Test1Button_pressed():
	if doPuzzle1(testPouch1, testPouch2) == test1Answer:
		test1Label.text = "PASS"
	else:
		test1Label.text = "FAIL"

func _on_Puzzle1Button_pressed():
	puzzle1Label.text = str(doPuzzle1(pouch1, pouch2))

func _on_Test2Button_pressed():
	if doPuzzle2(testPouch1, testPouch2) == test2Answer:
		test2Label.text = "PASS"
	else:
		test2Label.text = "FAIL"

func _on_Puzzle2Button_pressed():
	puzzle2Label.text = str(doPuzzle2(pouch1, pouch2))
