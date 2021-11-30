extends Node
class_name Diario, "./Diario.icon.png"

## entrada: Dictionary
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
func escribir_renglon(texto_del_renglon: String):
	escribir_entrada_de_texto(texto_del_renglon)

func agregar_foto(nombre_foto: String, epigrafe_elegido: String):
	self.agregar_entrada({
		"tipo": "foto",
		"tamanio": 8,
		"epigrafe": epigrafe_elegido,
		"nombre_foto": nombre_foto,
	})

func agregar_carta(nombre_carta: String):
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

func contiene_foto(nombre_foto: String) -> bool:
	for entrada in entradas:
		if entrada['tipo'] == "foto" and entrada['nombre_foto'] == nombre_foto:
			return true
	return false

## Devuelve una string vacía si todavía no se tomo la foto
func epigrafe_elegido_para(nombre_foto: String) -> String:
	for entrada in entradas:
		if entrada['tipo'] == "foto" and entrada['nombre_foto'] == nombre_foto:
			return entrada['epigrafe']
	return ""

# Todavia no me encuentro decidido sobre si esto tiene sentido tratarlo como
# un objeto separado (como Memoria o algo así) o registrar los hitos directamente
# como entradas en el diario que no se muestran en la vista del mismo.
# De todas maneras, la interface de las escenas expone otra api para interactuar
# con esto. 

## nombre_hito: String
signal hito_fue_registrado

var hitos = []

func registrar_hito(nombre_hito: String):
	if not el_hito_fue_registrado(nombre_hito):
		hitos.append(nombre_hito)
		emit_signal("hito_fue_registrado", nombre_hito)
	
func el_hito_fue_registrado(nombre_hito: String) -> bool:
	return hitos.has(nombre_hito)
