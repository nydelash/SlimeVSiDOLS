extends Label

var velocidad = -40
var tiempo = 1.0


func _process(delta):

	position.y += velocidad * delta

	tiempo -= delta

	if tiempo <= 0:
		queue_free()
