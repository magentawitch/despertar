extends Node
class_name Diario, "./Diario.icon.png"

# TODO: Sacar de acá todo el detalle de cuantos renglones hay por página
# y que va en cada página. Resolver todo eso en la VistaDiario.
var paginas = [[]]  # Arranca con una página vacía
const TAMANIO_PAGINA = 16 # Renglones
var espacio_disponible_en_la_ultima_pagina = TAMANIO_PAGINA

func agregar_entrada(entrada):
	if self.espacio_disponible_en_la_ultima_pagina >= entrada["tamanio"]:
		self.espacio_disponible_en_la_ultima_pagina -= entrada["tamanio"]
		self.paginas[-1].append(entrada)
	else:
		self.espacio_disponible_en_la_ultima_pagina = TAMANIO_PAGINA - entrada["tamanio"]
		self.paginas.append([entrada])
	
func cantidad_de_paginas_ocupadas():
	return self.paginas.size()

func entradas_de_la_pagina(n):
	return self.paginas[n]

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

func agregar_foto(escena_foto):
	self.agregar_entrada({
		"tipo": "foto",
		"tamanio": 8,
		"escena_foto": escena_foto,
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
