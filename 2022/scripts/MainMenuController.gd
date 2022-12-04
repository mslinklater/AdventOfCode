extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Day1_Button_pressed():
	get_tree().change_scene("res://scenes/Day1.tscn")

func _on_Day2Button_pressed():
	get_tree().change_scene("res://scenes/Day2.tscn")

func _on_Day3Button_pressed():
	get_tree().change_scene("res://scenes/Day3.tscn")
