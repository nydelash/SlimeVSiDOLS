extends Node

@export var enemy_scene: PackedScene
@export var path: Path2D

var enemigos = []


func _on_timer_timeout():

	var path_follow = PathFollow2D.new()
	path_follow.loop = false
	path.add_child(path_follow)

	var enemigo = enemy_scene.instantiate()
	path_follow.add_child(enemigo)

	enemigos.append(path_follow)


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

		if e.progress_ratio >= 1.0:

			print("enemigo llegó a la base")

			var base = get_node("/root/Main/Base")
			base.recibir_daño(1)

			enemigos.erase(e)
			e.queue_free()
