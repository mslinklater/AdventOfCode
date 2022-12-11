extends Node2D

var day1_scene = preload("res://scenes/Day1.tscn").instantiate()
var day2_scene = preload("res://scenes/Day2.tscn").instantiate()

@onready var day_load_node = get_node("CanvasLayer/Control/HSplitContainer/AnswerContainer")

func _ready():
	pass # Replace with function body.

func load_day(day_scene):
	if day_load_node.get_child_count() > 0:
		for child in day_load_node.get_children():
			day_load_node.remove_child(child)
	day_load_node.add_child(day_scene)

func _on_Day1_Button_pressed():
	load_day(day1_scene)
#	day_load_node.add_child(day1_scene)

func _on_Day2Button_pressed():
	load_day(day2_scene)
#	day_load_node.add_child(day2_scene)
#	get_tree().change_scene_to_file("res://scenes/Day2.tscn")

func _on_Day3Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Day3.tscn")

func _on_Day4Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Day4.tscn")

func _on_3DModeButton_pressed():
	get_tree().change_scene_to_file("res://scenes/3DMode.tscn")

func _on_Day5Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Day5.tscn")

func _on_Day6Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Day6.tscn")

func _on_Day7Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Day7.tscn")

func _on_Day8Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Day8.tscn")

func _on_Day9Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Day9.tscn")

func _on_Day10Button_pressed():
	get_tree().change_scene_to_file("res://scenes/Day10.tscn")

func _on_day_11_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Day11.tscn")
