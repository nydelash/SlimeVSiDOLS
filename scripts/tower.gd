extends Node2D

# ==============================
# CONFIGURACIÓN GENERAL
# ==============================

var es_preview = false                 # indica si esta torre es solo el "ghost" antes de colocarla

@export var costo = 25                 # costo de construir la torre

@export var projectile_scene: PackedScene   # escena del proyectil que dispara la torre


# ==============================
# VARIABLES DE COMBATE
# ==============================

var enemigos_en_rango = []             # lista de enemigos dentro del área de detección
var objetivo = null                    # enemigo actual al que apunta la torre

var cooldown = 0.0                     # temporizador interno entre disparos
var fire_rate = 1.0                    # tiempo entre disparos (segundos)


# ==============================
# LOOP PRINCIPAL
# ==============================
# Se ejecuta cada frame

func _process(delta):

	# si la torre es solo preview no ejecutar lógica
	if es_preview:
		return

	# limpiar enemigos inválidos (cuando mueren)
	enemigos_en_rango = enemigos_en_rango.filter(func(e): return is_instance_valid(e))

	# si hay enemigos en rango
	if enemigos_en_rango.size() > 0:

		objetivo = enemigos_en_rango[0]

		if is_instance_valid(objetivo):

			# girar hacia el enemigo
			look_at(objetivo.global_position)

			# actualizar cooldown
			cooldown -= delta

			if cooldown <= 0:
				disparar()
				cooldown = fire_rate


# ==============================
# DISPARAR PROYECTIL
# ==============================

func disparar():

	if objetivo == null:
		return

	if !is_instance_valid(objetivo):
		return

	var proyectil = projectile_scene.instantiate()

	get_tree().current_scene.add_child(proyectil)

	proyectil.global_position = global_position

	# dirección hacia el enemigo
	proyectil.direccion = (objetivo.global_position - global_position).normalized()

	print("torre dispara")


# ==============================
# ACTIVAR MODO PREVIEW
# ==============================
# Se usa cuando la torre aparece como fantasma
# antes de ser colocada en el grid.

func activar_preview():

	es_preview = true

	# desactivar detección de enemigos
	$Range.monitoring = false
	$Range.monitorable = false


# ==============================
# ENEMIGO ENTRA AL RANGO
# ==============================

func _on_range_body_entered(body):

	# evitar que el preview detecte enemigos
	if es_preview:
		return

	print("enemigo detectado")

	enemigos_en_rango.append(body)


# ==============================
# ENEMIGO SALE DEL RANGO
# ==============================

func _on_range_body_exited(body):

	if enemigos_en_rango.has(body):

		print("enemigo salió del rango")

		enemigos_en_rango.erase(body)
