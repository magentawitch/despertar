extends Node2D

class_name Personaje, "res://assets/iconos/singleplayer.png"

export var sprite_path: NodePath
export var velocidad: float = 450.0
var facing = "right"

func sprite() -> Sprite:
	return get_node(sprite_path) as Sprite

func _process(delta: float) -> void:
	var desplazamiento = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		desplazamiento.x += 1
	if Input.is_action_pressed("ui_left"):
		desplazamiento.x -= 1
		
	if desplazamiento.length() > 0:
		desplazamiento = desplazamiento.normalized() * velocidad * delta
		
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("camina")
		
		if facing == "left" and desplazamiento.x > 0:
			facing = "right"
			sprite().scale.x = -sprite().scale.x
			
		if facing == "right" and desplazamiento.x < 0:
			facing = "left"
			sprite().scale.x = -sprite().scale.x
	else:
		if $AnimationPlayer.is_playing():
			$AnimationPlayer.seek(0)
			$AnimationPlayer.stop()
		
	position += desplazamiento
	
