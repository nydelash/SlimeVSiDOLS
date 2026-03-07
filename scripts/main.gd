extends Node2D

var dinero = 100
var esencia_fuego = 0

@onready var money_label = $UI/MoneyLabel
@onready var fire_essence_label = get_node("UI/FireEssenceLabel")


func _ready():
	actualizar_ui()


func actualizar_ui():
	money_label.text = "Dinero: " + str(dinero)
	fire_essence_label.text = "Fire Essence: " + str(esencia_fuego)




#func _on_tower1_button_pressed():
#	var build_grid = get_node("BuildGrid")
#	build_grid.torre_seleccionada = preload("res://scenes/towers/tower.tscn")
#	print("basic slime seleccionado")


#func _on_tower2_button_pressed():
#	var build_grid = get_node("BuildGrid")
#	build_grid.torre_seleccionada = preload("res://scenes/towers/fire_tower.tscn")
#	print("fire slime seleccionado")


func _on_tower_1_button_pressed() -> void:
	var build_grid = get_node("BuildGrid")

	build_grid.torre_seleccionada = preload("res://scenes/towers/tower.tscn")

	print("basic slime seleccionado")


func _on_tower_2_button_pressed() -> void:
	var build_grid = get_node("BuildGrid")

	build_grid.torre_seleccionada = preload("res://scenes/towers/fire_tower.tscn")

	print("fire slime seleccionado")
