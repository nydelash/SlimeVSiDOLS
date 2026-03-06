extends Node

@export var spawner : Node

var wave_actual = 0
var max_waves = 10
var enemigos_restantes = 0
var juego_terminado = false
var wave_en_progreso = false

@export var tiempo_entre_waves = 10
@export var tiempo_inicial = 5


@onready var wave_label = get_node("/root/Main/UI/WaveLabel")
@onready var enemies_label = get_node("/root/Main/UI/EnemiesLabel")


func _ready():

	actualizar_ui()

	print("Preparación inicial...")

	await get_tree().create_timer(tiempo_inicial).timeout

	iniciar_wave()



func iniciar_wave():
	
	if juego_terminado:
		return

	if wave_actual >= max_waves:
		print("Juego completado")
		return

	wave_actual += 1
	wave_en_progreso = true

	enemigos_restantes = 5 + wave_actual * 2

	print("Iniciando wave: ", wave_actual)

	actualizar_ui()

	spawner.spawn_wave(enemigos_restantes, wave_actual)



func enemigo_muerto():
	
	if juego_terminado:
		return

	enemigos_restantes -= 1

	actualizar_ui()

	if enemigos_restantes <= 0:

		wave_en_progreso = false

		print("Wave completada")

		await get_tree().create_timer(tiempo_entre_waves).timeout

		iniciar_wave()


func lanzar_wave_manual():

	if wave_en_progreso:
		return

	print("Wave lanzada manualmente")

	iniciar_wave()



func actualizar_ui():

	wave_label.text = "Wave: " + str(wave_actual) + " / " + str(max_waves)

	enemies_label.text = "Enemies: " + str(enemigos_restantes)

func _on_next_wave_button_pressed():

	lanzar_wave_manual()
