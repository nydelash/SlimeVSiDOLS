extends CharacterBody2D

@export var floating_text_scene : PackedScene
@export var recompensa = 10
@export var stats : EnemyStats

var hp_actual
@onready var health_bar = $Visuals/HealthBar


func _ready():

	hp_actual = stats.hp

	health_bar.min_value = 0
	health_bar.max_value = stats.hp
	health_bar.value = hp_actual


func recibir_daño(dmg):

	hp_actual -= dmg

	health_bar.value = hp_actual

	print("hp enemigo:", hp_actual)

	if hp_actual <= 0:
		morir()


func morir():

	var main = get_tree().current_scene

	main.dinero += recompensa
	main.actualizar_ui()

	var texto = floating_text_scene.instantiate()
	get_tree().current_scene.add_child(texto)

	texto.global_position = global_position
	texto.text = "+" + str(recompensa)

	get_parent().queue_free()

func _process(delta):

	rotation = 0
