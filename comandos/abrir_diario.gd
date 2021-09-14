extends Node


export var path_a_la_vista_del_diario: NodePath

func vista_diario() -> VistaDiario:
	return get_node(path_a_la_vista_del_diario) as VistaDiario


func abrir_diario(scheduler: Scheduler, detalles: Dictionary) -> void:
	vista_diario().mostrar()
	print("Mostrando el diario")
	yield(vista_diario(), "solicitaron_cerrarme")
	vista_diario().ocultar()
	print("Ocultando el diario")
	scheduler.termino_la_ejecucion_del_comando()
