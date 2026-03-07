extends Node2D

@export var tipo = "fire"


func recoger():

	var main = get_tree().current_scene

	main.esencia_fuego += 1

	main.actualizar_ui()

	queue_free()


func _on_area_2d_input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton and event.pressed:
		recoger()
