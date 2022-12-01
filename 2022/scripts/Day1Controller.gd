extends Node2D

# Answer 1 = 69795
# Answer 1 = 208437

onready var file = 'res://input/day1.txt'
onready var puzzle1AnswerLabel: Label = get_node("Puzzle1AnswerLabel")
onready var puzzle2AnswerLabel: Label = get_node("Puzzle2AnswerLabel")

var totals = []

# Called when the node enters the scene tree for the first time.
func _ready():
	parse_file()

func parse_file():
	var f = File.new()
	f.open(file, File.READ)
	var thisTotal = 0
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		if line.length() > 0:
			thisTotal += int(line)
		else:
			totals.append(thisTotal)
			thisTotal = 0
	f.close()

func _on_Mainmenu_Button_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_Puzzle1Button_pressed():
	var largest = 0
	for val in totals:
		if val > largest:
			largest = val
	puzzle1AnswerLabel.text = str(largest)

func _on_Puzzle2Button_pressed():
	var sortedTotals = totals
	sortedTotals.sort()
	var topThreeTotal = sortedTotals[sortedTotals.size()-1] + sortedTotals[sortedTotals.size()-2] + sortedTotals[sortedTotals.size()-3]
	puzzle2AnswerLabel.text = str(topThreeTotal)
	
