extends Node
class_name Diario, "./Diario.icon.png"

signal entrada_agregada

var entradas = []

func obtener_todas_las_entradas():
	return entradas

func agregar_entrada(entrada):
	entradas.append(entrada)
	emit_signal("entrada_agregada", entrada)

func escribir_entrada_de_texto(texto: String):
	print("Escribió: " + texto)
	self.agregar_entrada({
		"tipo": "texto",
		"tamanio": texto.split("\n").size(),
		"texto": texto,
	})

# TODO: Deprecar
func escribir_renglon(texto_del_renglon):
	escribir_entrada_de_texto(texto_del_renglon)

func agregar_foto(nombre_foto, epigrafe_elegido):
	self.agregar_entrada({
		"tipo": "foto",
		"tamanio": 8,
		"epigrafe": epigrafe_elegido,
		"nombre_foto": nombre_foto,
	})

func agregar_carta(nombre_carta):
	self.agregar_entrada({
		"tipo": "carta",
		"nombre_carta": nombre_carta,
	})

func _interaccion_de_ejemplo(diario: Diario):
	diario.escribir_entrada_de_texto("""
		Querido diario...
		Viene Diego rumbeando
		Bueno, ahora en serio...
		Estoy muy preocupade por la
		recuperación de mi abuele.
	""".strip_edges())
	# diario.agregar_foto("fotoConLeBobe")
	# diario.agregar_epigrafe("fotoConLeBobe", "caraDePreocupación")
	# diario.registrar_hito("leBobeSeCuró")
	# if diario.el_hito_fue_registrado("leBobeSeCuró"):
	# 	diario.escribir_renglon("Yay! Mi abuele se siente mejor :smile:")
