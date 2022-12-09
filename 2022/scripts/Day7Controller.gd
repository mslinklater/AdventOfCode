extends Node2D

# answer 1 - 2061777
# answer 2 - 4473403

onready var puzzle1Label: Label = get_node("Puzzle1Label")
onready var puzzle2Label: Label = get_node("Puzzle2Label")

var test_e_size = 584
var test_a_size = 94853
var test_d_size = 24933642
var test_root_size = 48381165
var testAnswer1 = 95437
var testAnswer2 = 24933642

# file system node
class FSNode:
	func _init():
		size = 0
		isDirectory = false
		children = []
		parent = 0
		name = ""

	var name: String
	var children: Array
	var parent
	var isDirectory: bool
	var size: int

onready var testRoot = FSNode.new()
onready var dataRoot = FSNode.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	parse_file('res://input/day7test.txt', testRoot)
	testRoot.size = calc_sizes(testRoot)
	parse_file('res://input/day7.txt', dataRoot)
	dataRoot.size = calc_sizes(dataRoot)

func parse_file(filename, root: FSNode):
	root.isDirectory = true
	var lines = []
	Utils.load_file_extract_lines(filename, lines)
	var currentNode = root
	for line in lines:
		var parts = line.split(" ")
		if parts[0] == "$": # command
			if parts[1] == "cd":
				if parts[2] == "/":
					currentNode = root
				elif parts[2] == "..":
					currentNode = currentNode.parent
				else:
					for node in currentNode.children:
						if node.name == parts[2] and node.isDirectory:
							currentNode = node
							break
			else: # ls
				pass
		elif parts[0] == "dir": # directory
			var newNode = FSNode.new()
			newNode.isDirectory = true
			newNode.name = parts[1]
			newNode.parent = currentNode
			currentNode.children.append(newNode)
		else: # file
			var newNode = FSNode.new()
			newNode.size = int(parts[0])
			newNode.name = parts[1]
			newNode.parent = currentNode
			currentNode.children.append(newNode)

func calc_sizes(node: FSNode) -> int:
	if node.isDirectory:
		for child in node.children:
			node.size += calc_sizes(child)
	return node.size

func dump_nodes(node: FSNode, cd: String):
	if node.isDirectory:
		cd = cd + "/" + node.name + "(dir) " + str(node.size)
		print(cd)
		for child in node.children:
			dump_nodes(child, cd)
	else:
		print(cd + "/" + node.name + " " + str(node.size))

func find_dir_size(root: FSNode, dirname) -> int:
	var found_dirs = []
	found_dirs.append(root)
	for dir in found_dirs:
		for child in dir.children:
			if child.isDirectory:
				found_dirs.append(child)
		if dir.name == dirname:
			print(dirname + " " + str(dir.size))
			return dir.size
	return 0

# sum size ofall directories over 100,000
func doPuzzle1(root: FSNode) -> int:
	var ret = 0
	var found_dirs = []
	found_dirs.append(root)
	for dir in found_dirs:
		for child in dir.children:
			if child.isDirectory:
				found_dirs.append(child)
		if dir.size <= 100000 and dir.name != "":
			ret += dir.size
	return ret

func doPuzzle2(root: FSNode) -> int:
	var requiredSpace = root.size - 40000000;
	var ret = root.size
	var found_dirs = []
	found_dirs.append(root)
	for dir in found_dirs:
		for child in dir.children:
			if child.isDirectory:
				found_dirs.append(child)
		if dir.size >= requiredSpace and dir.size < ret:
			ret = dir.size
	return ret
	
func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Puzzle1Button_pressed():
	if find_dir_size(testRoot, "e") != test_e_size:
		puzzle1Label.text = "e FAIL"
	elif find_dir_size(testRoot, "a") != test_a_size:
		puzzle1Label.text = "a FAIL"
	elif find_dir_size(testRoot, "d") != test_d_size:
		puzzle1Label.text = "d FAIL"
	elif find_dir_size(testRoot, "") != test_root_size:
		puzzle1Label.text = "root FAIL"
	else:
		if doPuzzle1(testRoot) == testAnswer1:
			puzzle1Label.text = str(doPuzzle1(dataRoot))
		else:
			puzzle1Label.text = "FAIL"

func _on_Puzzle2Button_pressed():
	if doPuzzle2(testRoot) == testAnswer2:
		puzzle2Label.text = str(doPuzzle2(dataRoot))
	else:
		puzzle2Label.text = "FAIL"
