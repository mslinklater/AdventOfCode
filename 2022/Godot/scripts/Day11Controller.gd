extends Node2D

# TODO: Make re-entrant
# TODO: Merge solve functions in to one ?

class Monkey:
	var items: Array
	var op_mult: int
	var op_add: int
	var test: int
	var true_throw: int
	var false_throw: int
	var num_throws: int
	
	func _init():
		items = []
		op_mult= 1
		op_add = 0
		
var testData = []
var realData = []

var test1Answer = 10605
var test2Answer = 2713310158

@onready var puzzle1Label: Label = get_node("Puzzle1Label")
@onready var puzzle2Label: Label = get_node("Puzzle2Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	parse_file('res://../puzzle_input/day11test.txt',testData)
	parse_file('res://../puzzle_input/day11.txt',realData)

func parse_file(filename, data: Array):
	var lines = []
	Utils.load_file_extract_lines(filename, lines)
	for i in range(lines.size()):
		if lines[i].contains("Monkey"):
			var entry = Monkey.new()
			var starting_items = lines[i+1].split(" ", false)
			for j in range(2, starting_items.size()):
				entry.items.push_back(int(starting_items[j].rstrip(",")))
			var op_items = lines[i+2].split(" ", false)
			if op_items[4] == "*":
				if(op_items[5] == "old"):
					entry.op_mult = -1 # sentinel for square
				else:
					entry.op_mult = int(op_items[5])
			else:	
				entry.op_add = int(op_items[5])
			entry.test = int(lines[i+3].split(" ", false)[3])
			entry.true_throw = int(lines[i+4].split(" ", false)[5])
			entry.false_throw = int(lines[i+5].split(" ", false)[5])
			data.append(entry)

func throw(m1: Monkey, m2:Monkey, worry_level):
	m1.items.remove_at(0)
	m2.items.append(worry_level)
	m1.num_throws += 1

func print_monkeys(data: Array, round):
	print("--- round " + str(round))
	for i in data.size():
		print(data[i].items)

func do_puzzle_1(data: Array) -> int:
	var monkey_business = 0
	for round in range(20):
		for monkey in data:
			while monkey.items.size() > 0:
				var num = monkey.items[0]
				if monkey.op_mult == -1:
					num *=num
				else:
					num *= monkey.op_mult
				num += monkey.op_add
				num = floor(num/3)
				var dest_monkey
				if num % monkey.test == 0:
					dest_monkey = monkey.true_throw
				else:
					dest_monkey = monkey.false_throw
				var monkey2 = data[dest_monkey]
				throw(monkey, monkey2, num)
#		print_monkeys(data, round+1)
	var throws = []
	for monkey in data:
		throws.append(monkey.num_throws)
	throws.sort()
	monkey_business = throws[throws.size()-1] * throws[throws.size()-2]
	return monkey_business

func do_puzzle_2(data: Array) -> int:
	var monkey_business = 0
	var divisor = 1
	for monkey in data:
		divisor *= monkey.test
	for round in range(10000):
		for monkey in data:
			while monkey.items.size() > 0:
				var num = monkey.items[0]
				if monkey.op_mult == -1:
					num *=num
				else:
					num *= monkey.op_mult
				num += monkey.op_add
				num = num % divisor
				var dest_monkey
				if num % monkey.test == 0:
					dest_monkey = monkey.true_throw
				else:
					dest_monkey = monkey.false_throw
				var monkey2 = data[dest_monkey]
				throw(monkey, monkey2, num)
#		print_monkeys(data, round+1)
	var throws = []
	for monkey in data:
		throws.append(monkey.num_throws)
	throws.sort()
	monkey_business = throws[throws.size()-1] * throws[throws.size()-2]
	return monkey_business

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_puzzle_1_button_pressed():
	if do_puzzle_1(testData) == test1Answer:
		puzzle1Label.text = str(do_puzzle_1(realData))
	else:
		puzzle1Label.text = "FAIL"

func _on_puzzle_2_button_pressed():
	if do_puzzle_2(testData) == test2Answer:
		puzzle2Label.text = str(do_puzzle_2(realData))
	else:
		puzzle2Label.text = "FAIL"
