extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Day1_Button_pressed():
	get_tree().change_scene("res://scenes/Day1.tscn")

func _on_Day2Button_pressed():
	get_tree().change_scene("res://scenes/Day2.tscn")
