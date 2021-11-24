extends Node2D

export var nombre_de_la_escena_de_prueba: String = "00_diario"
export var nombre_de_la_escena_actual: String = "00_diario"
export var velocidad_de_la_camara: float = 450.0
export var distancia_foco: float = 50.0

signal la_escena_fue_cambiada

func _ready() -> void:
	if OS.is_debug_build():
		print("Como estoy en debug arranco con la escena de test: ", nombre_de_la_escena_de_prueba)
		nombre_de_la_escena_actual = nombre_de_la_escena_de_prueba
	cargar_escena_actual()
	$telon.visible = true
	#$ui/vista_diario.visible = false
	$ui/eleccion_de_epigrafe.visible = false
	$director.connect("aparecieron_acciones_pendientes", $ui/menu, 'hide')
	$director.connect("se_acabaron_las_acciones_pendientes", $ui/menu, 'show')


# TODO: Mover la lógica relacionada a saber donde está el jugador a otro lado
var personaje_objetivo = null

func _buscar_personaje_dfs(nodo) -> Personaje:
	for c in nodo.get_children():
		if c is Personaje:
			return c
		var p = _buscar_personaje_dfs(c)
		if p:
			return p
	return null

func _process(delta: float) -> void:
	if not personaje_objetivo:
		return
	var dist_personaje = $camara.get_global_transform().get_origin().x - personaje_objetivo.get_global_transform().get_origin().x
	var personaje_esta_a_la_izquierda = dist_personaje > 0.1
	var personaje_esta_a_la_derecha = dist_personaje < -0.1
	
	var desplazamiento = Vector2()
	if personaje_esta_a_la_izquierda and $camara.hay_lugar_a_la_izquierda:
		desplazamiento.x += 1
	if personaje_esta_a_la_derecha and $camara.hay_lugar_a_la_derecha:
		desplazamiento.x -= 1
	if desplazamiento.length() > 0:
		if abs(dist_personaje) < distancia_foco:
			desplazamiento = Vector2(dist_personaje / 2, 0)
		else:
			desplazamiento = desplazamiento.normalized() * velocidad_de_la_camara * delta 
	
	$contenedor.position += desplazamiento
	

# TODO: Mover la lógica relacionada a cargar escenas al $contenedor	
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
	
	# Relacionado a posición
	$contenedor.position = Vector2.ZERO
	personaje_objetivo = _buscar_personaje_dfs($contenedor)
	
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
