extends TileMapLayer

var preview_torre = null
var preview_cell = Vector2i.ZERO

var torre_seleccionada = null
var main

@export var map_layer : TileMapLayer

var torres_colocadas = {}


func _ready():
	main = get_tree().current_scene


func _input(event):

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:

			var mouse_pos = get_global_mouse_position()
			var cell = local_to_map(to_local(mouse_pos))

			place_tower(cell)


func place_tower(cell):

	# evitar colocar si preview está rojo
	if preview_torre and preview_torre.modulate.r > preview_torre.modulate.g:
		return

	# evitar colocar torre donde ya hay una
	if torres_colocadas.has(cell):
		return

	# bloquear camino
	var tile_data = map_layer.get_cell_tile_data(cell)
	if tile_data and tile_data.get_custom_data("camino"):
		return

	# debe haber una torre seleccionada
	if torre_seleccionada == null:
		return

	# crear instancia temporal para leer costo
	var temp_tower = torre_seleccionada.instantiate()
	var costo = temp_tower.costo

	# verificar dinero
	if main.dinero < costo:
		print("no hay dinero")
		temp_tower.queue_free()
		return

	# descontar dinero
	main.dinero -= costo
	main.actualizar_ui()

	# colocar torre
	var world_pos = map_to_local(cell)

	get_node("/root/Main/Towers").add_child(temp_tower)
	temp_tower.global_position = world_pos

	torres_colocadas[cell] = temp_tower


func crear_preview():

	if torre_seleccionada == null:
		return

	if preview_torre != null:
		return

	preview_torre = torre_seleccionada.instantiate()

	get_node("/root/Main/Towers").add_child(preview_torre)

	preview_torre.modulate = Color(1,1,1,0.5)


func _process(delta):

	if torre_seleccionada == null:
		return

	crear_preview()

	var mouse_pos = get_global_mouse_position()
	var cell = local_to_map(to_local(mouse_pos))

	if preview_torre:

		var world_pos = map_to_local(cell)
		preview_torre.global_position = world_pos

		actualizar_color_preview(cell)


func actualizar_color_preview(cell):

	var bloqueado = false

	if torres_colocadas.has(cell):
		bloqueado = true

	var tile_data = map_layer.get_cell_tile_data(cell)
	if tile_data and tile_data.get_custom_data("camino"):
		bloqueado = true

	if bloqueado:
		preview_torre.modulate = Color(1,0.4,0.4,0.6)
	else:
		preview_torre.modulate = Color(0.4,1,0.4,0.6)
