extends Node

export var path_al_diario: NodePath
export var path_a_la_vista_del_diario: NodePath
export var path_a_la_vista_de_eleccion_del_epigrafe: NodePath

func diario() -> Diario:
	return get_node(path_al_diario) as Diario
	
func vista_diario() -> VistaDiario:
	return get_node(path_a_la_vista_del_diario) as VistaDiario

func vista_eleccion_epigrafe() -> EleccionDeEpigrafe:
	return get_node(path_a_la_vista_de_eleccion_del_epigrafe) as EleccionDeEpigrafe

func agrega_foto(director: Director, detalles: Dictionary):
	print("Agregando foto")
	
	# Mostrar el diario de fondo
	vista_diario().mostrar_de_forma_no_interactiva()
	
	# Mostrar el dialogo de elección de foto
	var nombre_foto = detalles['nombre_foto']
	vista_eleccion_epigrafe().mostrar_foto(nombre_foto)
	var epigrafe_elegido = yield(vista_eleccion_epigrafe(), "opcion_elegida")
	
	# Agregar entrada al diario junto con la opcion elegida
	diario().agregar_foto(nombre_foto, epigrafe_elegido)
	yield(vista_diario(), "entrada_agregada")
	vista_diario().cambiar_a_ultima_pagina()
	
	# Mostrar el diario de nuevo de forma interactiva
	# (asi se habilitan los botones y se muestra la nueva entrada)
	print("Mostrando el diario post foto")
	vista_diario().mostrar()
	yield(vista_diario(), "solicitaron_cerrarme")
	vista_diario().ocultar()
	print("Ocultando el diario")
	director.termino_la_ejecucion_de_la_accion()
