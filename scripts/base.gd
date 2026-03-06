extends Node2D

var vida = 10

@onready var label = get_tree().current_scene.get_node("UI/BaseHP")

func recibir_daño(cantidad):

	vida -= cantidad

	label.text = "Base HP: " + str(vida)

	if vida <= 0:
		game_over()


func game_over():

	var wave_manager = get_tree().current_scene.get_node("WaveManager")

	wave_manager.juego_terminado = true

	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
