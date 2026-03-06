extends Control


# volver a iniciar la partida
func _on_retry_button_pressed():

	get_tree().change_scene_to_file("res://scenes/main.tscn")


# volver al menú principal
func _on_menu_button_pressed():

	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
