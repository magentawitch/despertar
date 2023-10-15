extends Node2D

export var velocidad_de_la_camara: float = 450.0
export var distancia_foco: float = 50.0
export var distancia_lejos: float = 800.0
export var nombre_de_la_escena_de_prueba: String = "02_pasillo_escuela"
export var nombre_de_la_escena_inicial: String = "00_diario"

signal la_escena_fue_cambiada

func _ready() -> void:
	$telon.visible = true
	$ui/menu_in_game.visible = false
	#$ui/vista_diario.visible = false
	$ui/eleccion_de_epigrafe.visible = false
	$foco.connect("cambio_de_modo", self, '_cuando_el_foco_cambia_de_modo')
	$director.connect("aparecieron_acciones_pendientes", $ui/menu, 'hide')
	$director.connect("se_acabaron_las_acciones_pendientes", $ui/menu, 'show')
	$director.connect("aparecieron_acciones_pendientes", $foco, 'entrar_en_modo_de_accion')
	$director.connect("se_acabaron_las_acciones_pendientes", $foco, 'entrar_en_modo_de_interaccion')
	$director.connect("se_acabaron_las_acciones_pendientes", $contenedor, '_cuando_se_acabaron_las_acciones_pendientes')
	$contenedor.connect("se_procedera_a_cargar_una_escena", self, "_antes_de_cargar_una_escena")
	$contenedor.connect("una_escena_fue_cargada", self, "_cuando_una_escena_fue_cargada")
	$ui/vista_diario.connect('solicita_ejecutar_accion', self, "_cuando_la_vista_diario_solicita_ejecutar_una_accion")
	$ui/menu_in_game.connect('se_cerro', self, "_cuando_se_cerro_el_menu_in_game")
	$ui/menu_in_game.connect('solicita_ejecutar_accion', self, "_cuando_el_menu_in_game_solicita_ejecutar_una_accion")
	$diario.connect('hito_fue_registrado', self, "_cuando_un_hito_fue_registrado")
	var parametros_de_inicio: Dictionary
	if OS.is_debug_build():
		print("Como estoy en debug arranco con la escena de test: ", nombre_de_la_escena_de_prueba)
		parametros_de_inicio["escena_inicial"] = nombre_de_la_escena_de_prueba
		
	$director.encolar("nueva_partida", parametros_de_inicio)
	
func _cuando_el_foco_cambia_de_modo(modo: ModoDeInteraccion):
	if modo.ocultar_menu_de_acciones_mientras_esta_colocado():
		ocultar_menu_de_acciones()
	else:
		mostrar_menu_de_acciones()

var _telon_first_time = true
func _antes_de_cargar_una_escena():
	if not _telon_first_time:
		$telon/anim.play("mostrar")
	_telon_first_time = false
	ocultar_menu_de_acciones()
	
func ocultar_menu_de_acciones():
	$ui/menu/boton_abrir_diario.visible = false
	$ui/menu/boton_camara.visible = false
	
func _cuando_una_escena_fue_cargada(escena: Escena):
	$telon/anim.play("ocultar")
	mostrar_menu_de_acciones()
	_ubicar_personaje()
	
func _ubicar_personaje():
	var nombre_de_la_escena_anterior = $contenedor.nombre_de_la_escena_anterior
	if nombre_de_la_escena_anterior:
		print("Debo tratar de ubicar a jade en %s" % nombre_de_la_escena_anterior)
		get_tree().call_group("MarcasDeEntrada", "teleportar_jade_si_venia_de", nombre_de_la_escena_anterior, self)

func teleportar_jade(marca: Position2D):
	var personaje = $foco.obtener_personaje_activo()
	personaje.global_position.x = marca.global_position.x
	
func mostrar_menu_de_acciones():
	var escena = $contenedor.obtener_escena_actual()
	$ui/menu.visible = escena.puede_ver_el_menu
	$ui/menu/boton_abrir_diario.visible = escena.puede_abrir_el_diario
	$ui/menu/boton_camara.visible = (
		escena.puede_tomar_fotos and $diario.el_hito_fue_registrado("consiguio_la_camara")
	)

func _cuando_un_hito_fue_registrado(nombre_hito: String):
	var escena = $contenedor.obtener_escena_actual() 
	$ui/menu/boton_camara.visible = (
		escena.puede_tomar_fotos and $diario.el_hito_fue_registrado("consiguio_la_camara")
	)
	
func _cuando_la_vista_diario_solicita_ejecutar_una_accion(accion: String, detalles: Dictionary):
	print("Vista diario solicito ejecutar la accion: %s detalles: %s" % [accion, detalles])
	if $ui/vista_diario.es_interactivo():
		$director.encolar(accion, detalles)
		$ui/vista_diario.cerrar()
		yield($director, "se_acabaron_las_acciones_pendientes")
		$director.encolar("abrir_diario")
		
	

# TODO: Mover esto a la camara
func _process(delta: float) -> void:
	
	if not $director.se_sigue_ejecutando_una_accion() and OS.is_debug_build():
		if Input.is_action_just_pressed("cargar_partida"):
			$director.encolar("cargar_partida", {})
		if Input.is_action_just_pressed("nueva_partida"):
			$director.encolar("nueva_partida", {})
		if Input.is_action_just_pressed("guardar_partida"):
			$director.encolar("guardar_partida", {})
		if Input.is_action_just_pressed("recargar_diario"):
			$ui/vista_diario.recargar()
		
	
	var personaje_activo = $foco.obtener_personaje_activo()
	if not personaje_activo:
		return
	var dist_personaje = $camara.get_global_transform().get_origin().x - personaje_activo.get_global_transform().get_origin().x
	var personaje_esta_a_la_izquierda = dist_personaje > 0.1
	var personaje_esta_a_la_derecha = dist_personaje < -0.1
	
	var desplazamiento = Vector2()
	if personaje_esta_a_la_izquierda and $camara.hay_lugar_a_la_izquierda:
		desplazamiento.x += 1
	if personaje_esta_a_la_derecha and $camara.hay_lugar_a_la_derecha:
		desplazamiento.x -= 1
	if desplazamiento.length() > 0.1:
		if abs(dist_personaje) < distancia_foco:
			desplazamiento = Vector2(dist_personaje / 2, 0)
		elif abs(dist_personaje) > distancia_lejos:
			desplazamiento = Vector2(dist_personaje / 2, 0)
		else:
			#desplazamiento = Vector2(dist_personaje / 8, 0)
			desplazamiento = desplazamiento.normalized() * velocidad_de_la_camara * delta 
	
	$contenedor.position += desplazamiento
	
func _on_boton_abrir_diario_pressed():
	$director.encolar("abrir_diario")

func _on_boton_abrir_menu_in_game_pressed() -> void:
	$ui/menu_in_game.mostrar()
	get_tree().paused = true

func _cuando_el_menu_in_game_solicita_ejecutar_una_accion(accion: String, detalles: Dictionary):
	print("Menu in game solicito ejecutar la accion: %s detalles: %s" % [accion, detalles])
	$director.encolar(accion, detalles)
	
func _cuando_se_cerro_el_menu_in_game():
	get_tree().paused = false
	
