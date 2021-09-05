extends Node

var paginas = [[]]  # Arranca con una página vacía
var espacio_disponible_en_la_ultima_pagina = 100  # Porcentaje, así es facil convertirlo a "renglones"

func registrar_evento(evento):
	var entrada = self._obtener_entrada(evento)
	if self.espacio_disponible_en_la_ultima_pagina > entrada["tamanio"]:
		self.espacio_disponible_en_la_ultima_pagina -= entrada["tamanio"]
		self.paginas[-1].append(entrada)
	else:
		self.espacio_disponible_en_la_ultima_pagina = 100 - entrada["tamanio"]
		self.paginas.append([entrada])
	
func _obtener_entrada(evento):
	if evento["tipo"] == "renglon":
		return {
			"tamanio": 10,
			"tipo": "renglon",
			"texto": evento["texto"],
		}
	else:
		push_error("Tipo de renglon invalido: " + evento["tipo"])
		assert(false)
		
func cantidad_de_paginas_ocupadas():
	return self.paginas.size()

func entradas_de_la_pagina(n):
	return self.paginas[n]

func escribir_renglon(texto_del_renglon):
	print("Escribió: " + texto_del_renglon)
	self.registrar_evento({
		"tipo": "renglon",
		"texto": texto_del_renglon,
	})

func _interaccion_de_ejemplo(diario):
	diario.escribir_renglon("Querido diario...")
	diario.escribir_renglon("Mira lo que se avecina a la vuelta de la esquina")
	diario.escribir_renglon("Viene Diego rumbeando")
	diario.escribir_renglon("Con la luna en las pupilas y su traje agua marina")
	diario.escribir_renglon("Van restos de contrabando")
	diario.escribir_renglon("Y donde más no cabe un alma allí mete a darse caña")
	diario.escribir_renglon("Poseído por el ritmo ragatanga")
	diario.escribir_renglon("Y el DJ que lo conoce toca el himno de las 12")
	diario.escribir_renglon("Para Diego la canción más deseada")
	diario.escribir_renglon("Y la baila y la goza y la canta")
	diario.escribir_renglon("...")
	diario.escribir_renglon("Bueno, ahora en serio")
	diario.escribir_renglon("Estoy muy preocupade por la recuperación de mi abuele")
	# diario.agregar_foto("fotoConLeBobe")
	# diario.agregar_epigrafe("fotoConLeBobe", "caraDePreocupación")
	# diario.registrar_hito("leBobeSeCuró")
	# if diario.el_hito_fue_registrado("leBobeSeCuró"):
	# 	diario.escribir_renglon("Yay! Mi abuele se siente mejor :smile:")
