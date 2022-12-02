extends Node2D

onready var test1Answer = 15

var testScores = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func parse_file(filename, data: Array):
	pass

# UI handlers

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
