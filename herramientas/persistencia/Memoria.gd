extends Node

class_name Memoria

var partida_guardada = null

func hay_una_partida_guardada() -> bool:
	return partida_guardada != null

func guardar_partida(partida: Dictionary):
	partida_guardada = partida.duplicate(true)

func cargar_partida() -> Dictionary:
	return partida_guardada.duplicate(true)
