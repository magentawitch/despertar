extends Node

export var path_a_la_vista_del_diario: NodePath

func vista_diario() -> VistaDiario:
	return get_node(path_a_la_vista_del_diario) as VistaDiario

export(NodePath) var path_al_oscurededor_de_fondo
onready var oscurecedor_de_fondo = get_node(path_al_oscurededor_de_fondo) as Sprite

func abrir_diario(director: Director, detalles: Dictionary) -> void:
	$"../../ui/menu/boton_abrir_diario/Notificacion".visible = false
	print("mostrando diario")
	oscurecedor_de_fondo.show()
	vista_diario().mostrar()
	print("Mostrando el diario")
	yield(vista_diario(), "solicitaron_cerrarme")
	vista_diario().ocultar()
	oscurecedor_de_fondo.hide()
	print("Ocultando el diario")
	director.termino_la_ejecucion_de_la_accion()
