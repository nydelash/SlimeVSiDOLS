extends Node

@export var enemy_scene: PackedScene
@export var path: Path2D

var enemigos = []


# ==============================
# SPAWN DE UNA WAVE
# ==============================

func spawn_wave(cantidad, wave):

	for i in cantidad:

		spawn_enemy(wave)

		await get_tree().create_timer(0.7).timeout



# ==============================
# CREAR UN ENEMIGO
# ==============================

func spawn_enemy(wave):

	var path_follow = PathFollow2D.new()
	path_follow.loop = false
	path.add_child(path_follow)

	var enemigo = enemy_scene.instantiate()

	# escalar estadísticas por wave
	if enemigo.stats:
		enemigo.stats.hp += wave * 5
		enemigo.stats.velocidad += wave * 2

	path_follow.add_child(enemigo)

	enemigos.append(path_follow)



# ==============================
# MOVIMIENTO DE ENEMIGOS
# ==============================

func _process(delta):

	for e in enemigos.duplicate():

		if !is_instance_valid(e):
			enemigos.erase(e)
			continue

		# evitar que el enemigo rote
		e.rotation = 0

		var enemigo = e.get_child(0)

		if enemigo and enemigo.stats:
			e.progress += enemigo.stats.velocidad * delta

		# enemigo llegó a la base
		if e.progress_ratio >= 1.0:

			print("enemigo llegó a la base")

			var base = get_node("/root/Main/Base")
			base.recibir_daño(1)
			
			var wave_manager = get_node_or_null("/root/Main/WaveManager")
			
			if wave_manager:
				wave_manager.enemigo_muerto()

			enemigos.erase(e)
			e.queue_free()
