extends Node2D

var dinero = 100

@onready var money_label = $UI/MoneyLabel


func _ready():
	actualizar_ui()


func actualizar_ui():
	money_label.text = "Dinero: " + str(dinero)




func _on_tower_1_button_pressed():
	$BuildGrid.torre_seleccionada = preload("res://scenes/tower.tscn")
