extends Node2D

var vida = 10

@onready var label = get_tree().current_scene.get_node("UI/BaseHP")

func recibir_daño(cantidad):

	vida -= cantidad

	label.text = "Base HP: " + str(vida)

	if vida <= 0:
		game_over()


func game_over():
	print("GAME OVER")
