extends Node2D

class_name Personaje, "res://assets/iconos/singleplayer.png"

export var sprite_path: NodePath
export var velocidad: float = 450.0
var facing = "right"

signal me_dirijo_hacia # posicion_destino: Vector2D
signal llegue_al_destino # posicion_destino: Vector2D

func sprite() -> Sprite:
	return get_node(sprite_path) as Sprite
	
var por_caminar: float = 0
var posicion_destino_actual: Vector2
	
func caminar_hacia(posicion_destino: Vector2):
	emit_signal("me_dirijo_hacia", posicion_destino)
	posicion_destino_actual = posicion_destino
	por_caminar = posicion_destino.x - get_global_transform().get_origin().x
	
func caminar(pixeles: float):
	por_caminar += pixeles
	
func caminar_a_la_izquierda(pixeles: float):
	por_caminar -= pixeles
	
func caminar_a_la_derecha(pixeles: float):
	por_caminar += pixeles

func _process(delta: float) -> void:
	if abs(por_caminar) > 0:
		
		if facing == "left" and por_caminar > 0:
			facing = "right"
			sprite().scale.x = -sprite().scale.x
			
		if facing == "right" and por_caminar < 0:
			facing = "left"
			sprite().scale.x = -sprite().scale.x
		
		var desplazamiento = clamp(
			sign(por_caminar) * velocidad * delta,
			-abs(por_caminar),
			abs(por_caminar)
		)
		position.x += desplazamiento
		por_caminar -= desplazamiento
		
		if abs(por_caminar) < 1:
			por_caminar = 0
		
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("camina")
		
	else:
		if $AnimationPlayer.is_playing():
			emit_signal("llegue_al_destino", posicion_destino_actual)
			$AnimationPlayer.seek(0)
			$AnimationPlayer.stop()
		
