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
@onready var next_wave_label = get_tree().current_scene.get_node("/root/Main/UI/NextWaveTimerLabel")

func cuenta_regresiva():

	for i in range(tiempo_entre_waves, 0, -1):

		next_wave_label.text = "Next wave in: " + str(i)

		await get_tree().create_timer(1).timeout

	next_wave_label.text = "Next wave in: 0"

func cuenta_regresiva_inicial():

	for i in range(tiempo_inicial, 0, -1):

		next_wave_label.text = "Next wave in: " + str(i)

		await get_tree().create_timer(1).timeout

	next_wave_label.text = "Next wave in: 0"
	
func _ready():

	actualizar_ui()

	print("Preparación inicial...")

	await cuenta_regresiva_inicial()

	iniciar_wave()



func iniciar_wave():
	next_wave_label.text = ""
	
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

	if enemigos_restantes <= 0:
		return

	enemigos_restantes -= 1

	actualizar_ui()

	if enemigos_restantes <= 0:

		enemigos_restantes = 0
		wave_en_progreso = false

		print("Wave completada")

		await cuenta_regresiva()

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
