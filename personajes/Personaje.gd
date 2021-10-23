extends Node2D

class_name Personaje, "res://assets/iconos/singleplayer.png"

export var sprite_path: NodePath
export var velocidad: float = 450.0
var facing = "right"

func sprite() -> Sprite:
	return get_node(sprite_path) as Sprite
	
var por_caminar: float = 0
	
func caminar_hacia(lugar: Vector2):
	por_caminar = lugar.x - get_global_transform().get_origin().x
	
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
			$AnimationPlayer.seek(0)
			$AnimationPlayer.stop()
		
