extends Node2D

export var nombre_de_la_escena_actual: String = "01_autopista"

signal la_escena_fue_cambiada

func _ready() -> void:
	cargar_escena_actual()

# TODO: Mover la lógica relacionada a cargar escenas al $contenedor	

func cargar_escena_actual():
	assert(
		nombre_de_la_escena_actual != null,
		"No hay una escena para cargar"
	)
	var escena = cargar_escena(nombre_de_la_escena_actual)
	
	escena._inicializar_dependencias($director, $diario)
	$contenedor.add_child(escena, true)
	escena.set_name('escena_actual')
	call_deferred('avisar_que_la_escena_fue_cargada')
	
func avisar_que_la_escena_fue_cargada():
	$telon/anim.play("ocultar")

func cargar_escena(nombre_de_la_escena) -> Escena:
	var archivo_de_la_escena = "res://escenas/%s.tscn" % nombre_de_la_escena
	assert(
		ResourceLoader.exists(archivo_de_la_escena),
		"No existe la escena: %s, deberia estar en: %s" % [
			nombre_de_la_escena_actual, archivo_de_la_escena
		]
	)
	var escena = load(archivo_de_la_escena).instance()
	assert(
		escena is Escena,
		"""La escena: %s no es del tipo Escena. (tip: Tiene que tener
		un script attacheado que arranque con: `extends Escena`)""" % [escena]
	)
	return escena as Escena

	
func cambiar_escena(nombre_de_escena_nueva):
	assert(
		true,
		"TODO: Hacer un chequeo de que la escena exista antes de cambiar"
	)
	$telon/anim.play("mostrar")
	yield($telon/anim, "animation_finished")
	var escena_previa = $contenedor.get_child(0)
	escena_previa.queue_free()
	yield(escena_previa, "tree_exited")
	nombre_de_la_escena_actual = nombre_de_escena_nueva
	cargar_escena_actual()
	emit_signal("la_escena_fue_cambiada")
