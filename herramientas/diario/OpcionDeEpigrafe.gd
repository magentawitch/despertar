extends MarginContainer

class_name OpcionDeEpigrafe

signal fue_elegido
signal gano_interes
signal perdio_interes


func asignar_texto(texto_epigrafe: String):
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	$VBoxContainer/Button.text = texto_epigrafe


func _on_Button_pressed() -> void:
	emit_signal("fue_elegido")


func _on_Button_mouse_entered() -> void:
	emit_signal("gano_interes")


func _on_Button_mouse_exited() -> void:
	emit_signal("perdio_interes")


static func crear() -> OpcionDeEpigrafe:
	return load('res://herramientas/diario/OpcionDeEpigrafe.tscn').instance()

func obtener_posicion_lapicera() -> Position2D:
	return $Position2D as Position2D
