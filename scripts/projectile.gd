extends Area2D

var velocidad = 500
var direccion = Vector2.ZERO

func _process(delta):

	position += direccion * velocidad * delta


func _on_body_entered(body):

	if body.has_method("recibir_daño"):

		body.recibir_daño(1)

		queue_free()
