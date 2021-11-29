extends MarginContainer

class_name EntradaDeDiario, "res://assets/iconos/menuList.png"

## accion: String, detalles: Dictionary
signal solicita_ejecutar_accion 

func inicializar_con(entrada: Dictionary):
	assert(
		false,
		"No implementado"
	)

static func cargar(tipo: String) -> EntradaDeDiario:
	var archivo_de_la_escena = "res://tipos_de_entrada_de_diario/%s.tscn" % tipo
	assert(
		ResourceLoader.exists(archivo_de_la_escena),
		"No existe el tipo de entrada: %s, deberia estar en: %s" % [
			tipo, archivo_de_la_escena
		]
	)
	return load(archivo_de_la_escena).instance() as EntradaDeDiario
