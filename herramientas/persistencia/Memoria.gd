extends Node

class_name Memoria

var partida_guardada = null

const archivo_partida_guardada = "user://savegame.save"

func hay_una_partida_guardada() -> bool:
	var save_game = File.new()
	return save_game.file_exists(archivo_partida_guardada)

func guardar_partida(partida: Dictionary):
	var save_game = File.new()
	save_game.open(archivo_partida_guardada, File.WRITE)
	save_game.store_line(to_json(partida))
	save_game.close()

func cargar_partida() -> Dictionary:
	var save_game = File.new()
	save_game.open(archivo_partida_guardada, File.READ)
	var partida_guardada = parse_json(save_game.get_line())
	save_game.close()
	return partida_guardada
