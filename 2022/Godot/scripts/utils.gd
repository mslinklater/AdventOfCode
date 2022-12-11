extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_file_extract_lines(filename, data: Array):
	var f = FileAccess.open(filename, FileAccess.READ)
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		data.append(line)
	
