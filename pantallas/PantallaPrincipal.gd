extends Node2D

export var nombre_de_la_escena_de_prueba: String = "04_pasillo_escuela2"
export var nombre_de_la_escena_actual: String = "00_diario"
export var velocidad_de_la_camara: float = 450.0

signal la_escena_fue_cambiada

func _ready() -> void:
	if OS.is_debug_build():
		print("Como estoy en debug arranco con la escena de test: ", nombre_de_la_escena_de_prueba)
		nombre_de_la_escena_actual = nombre_de_la_escena_de_prueba
	cargar_escena_actual()
	$telon.visible = true
	$ui/vista_diario.visible = false
	$ui/eleccion_de_epigrafe.visible = false
	$director.connect("aparecieron_acciones_pendientes", $ui/menu, 'hide')
	$director.connect("se_acabaron_las_acciones_pendientes", $ui/menu, 'show')

# TODO: Mover la lógica relacionada a cargar escenas al $contenedor	

func _process(delta: float) -> void:
	var desplazamiento = Vector2()
	if Input.is_action_pressed("ui_right"):
		desplazamiento.x -= 1
	if Input.is_action_pressed("ui_left"):
		desplazamiento.x += 1
	if desplazamiento.length() > 0:
		desplazamiento = desplazamiento.normalized() * velocidad_de_la_camara * delta
	
	$contenedor.position += desplazamiento
	

func cargar_escena_actual():
	assert(
		nombre_de_la_escena_actual != null,
		"No hay una escena para cargar"
	)
	var escena = cargar_escena(nombre_de_la_escena_actual)
	$ui/menu/boton_abrir_diario.visible = escena.puede_abrir_el_diario
	escena._inicializar_dependencias($director, $diario)
	$contenedor.add_child(escena, true)
	escena.set_name('escena_actual')
	$contenedor.position = Vector2.ZERO
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


func _on_boton_abrir_diario_pressed():
	
	$director.encolar("abrir_diario")
