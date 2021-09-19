extends Node2D


# Declare member variables here. Examples:
export var pantallaDestino = "res://XXXXX.tscn"
export var texturaNormal : Texture = null
export var texturaHover : Texture = null
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_mouse_entered():
	print ("Mouse entro a boton")
	if texturaHover:
		$Sprite.set_texture(texturaHover)
	else:
		$Sprite.modulate = Color(0, 1, 1, 1)


func _on_Area2D_mouse_exited():
	print ("Mouse salio del boton")
	$Sprite.modulate = Color(1, 1, 1, 1)
	if texturaNormal:
		$Sprite.set_texture(texturaNormal)


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		get_tree().change_scene(pantallaDestino)
