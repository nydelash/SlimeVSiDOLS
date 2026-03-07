extends CharacterBody2D


# ==============================
# ESCENAS / RECURSOS / VARIABLES
# ==============================

@export var floating_text_scene : PackedScene
@export var essence_scene : PackedScene
@export var stats : EnemyStats
@export var recompensa = 10
var hp_actual
@onready var health_bar = $Visuals/HealthBar


# ==============================
# INICIO
# ==============================

func _ready():

	hp_actual = stats.hp

	health_bar.min_value = 0
	health_bar.max_value = stats.hp
	health_bar.value = hp_actual


# ==============================
# RECIBIR DAÑO
# ==============================

func recibir_daño(dmg):

	hp_actual -= dmg

	health_bar.value = hp_actual

	print("hp enemigo:", hp_actual)

	if hp_actual <= 0:
		morir()


# ==============================
# MUERTE DEL ENEMIGO
# ==============================

func morir():

	# intentar dropear esencia
	intentar_drop()

	# avisar al WaveManager
	var wave_manager = get_tree().current_scene.get_node_or_null("WaveManager")

	if wave_manager:
		wave_manager.enemigo_muerto()

	# dar dinero al jugador
	var main = get_tree().current_scene

	main.dinero += recompensa
	main.actualizar_ui()

	# texto flotante +dinero
	var texto = floating_text_scene.instantiate()
	get_tree().current_scene.add_child(texto)

	texto.global_position = global_position
	texto.text = "+" + str(recompensa)

	# eliminar enemigo
	get_parent().queue_free()


# ==============================
# DROP DE ESENCIA
# ==============================

func intentar_drop():

	var chance = randf()

	if chance < 0.5: # 50%probabilidad

		if essence_scene:

			var esencia = essence_scene.instantiate()

			get_tree().current_scene.add_child(esencia)

			esencia.global_position = global_position


# ==============================
# EVITAR ROTACIÓN
# ==============================

func _process(delta):

	rotation = 0
