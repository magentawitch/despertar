extends Node2D
class_name Escena, "res://assets/iconos/door.png"

export var puede_abrir_el_diario = true
export var puede_tomar_fotos = true
export var puede_ver_el_menu = true

## El diario es de solo lectura
var diario_sl: Diario
var director: Director

signal termino_dialogo

func _inicializar_dependencias(director: Director, diario: Diario):
	self.diario_sl = diario
	self.director = director
	print("Escena: %s inicializada!" % get_name())

static func cargar(nombre_de_la_escena: String) -> Escena:
	var archivo_de_la_escena = "res://escenas/%s.tscn" % nombre_de_la_escena
	assert(
		ResourceLoader.exists(archivo_de_la_escena),
		"No existe la escena: %s, deberia estar en: %s" % [
			nombre_de_la_escena, archivo_de_la_escena
		]
	)
	var escena = load(archivo_de_la_escena).instance()
	assert(
		true, # escena is Escena, 
		"""La escena: %s no es del tipo Escena. TIP: Tiene que tener
		un script attacheado que arranque con: `extends Escena`""" % [escena]
		## Parece que godot no puede llamar `x is X` dentro de funciones estáticas
	)
	return escena as Escena

func _cuando_se_acabaron_las_acciones_pendientes():
	emit_signal("termino_dialogo")

###############################
# API para scripting de escenas
###############################

func abrir_diario():
	director.encolar("abrir_diario", {})

func anota_en_el_diario(texto: String):
	director.encolar("anotar", {"texto": texto})
	
func agregar_un_salto_de_linea_en_el_diario():
	director.encolar("anotar", {"texto": ""})

func agrega_foto_al_diario(nombre_foto):
	director.encolar("agrega_foto", {"nombre_foto": nombre_foto})

func anotar_en_el_diario(algo):
	anota_en_el_diario(algo)

func protagonista_piensa(algo):
	print(algo)
	
func cinematica(descrpcion):
	pass
	
func ya_saco_foto(nombre_foto) -> bool:
	return diario_sl.contiene_foto(nombre_foto)

func no_saco_foto(nombre_foto) -> bool:
	return not ya_saco_foto(nombre_foto)
	
func ya_ocurrio_que(nombre_hito) -> bool:
	return diario_sl.el_hito_fue_registrado(nombre_hito)
	
func no_ocurrio_que(nombre_hito) -> bool:
	return not diario_sl.el_hito_fue_registrado(nombre_hito)
	
func epigrafe_elegido_para(nombre_foto) -> String:
	return diario_sl.epigrafe_elegido_para(nombre_foto)
	
func registrar_hito(nombre_hito):
	director.encolar("registrar_hito", {"nombre_hito": nombre_hito})

func cambiar_escena_a(nombre_de_escena):
	director.encolar("cambio_de_escena", {"escena": nombre_de_escena})
	
func ver_carta(nombre_carta):
	director.encolar("ver_carta", {"nombre_carta": nombre_carta})

func agregar_carta(nombre_carta):
	director.encolar("agregar_carta", {"nombre_carta": nombre_carta})

func dice_a_la_grabadora(texto):
	grabar(texto)
	
func se_rie(quien):
	pass
	
func agarrar_camara():
	registrar_hito("consiguio_la_camara")
	
func tiene_la_camara():
	return diario_sl.el_hito_fue_registrado("consiguio_la_camara")
	
func grabar(texto):
	director.encolar("dice", {"texto": texto, "recuadro": "grabadora"})

func dice(quien, dialogo):
	director.encolar("dice", {"texto": dialogo, "recuadro": quien})

func elige(opciones):
	director.encolar('elige', {"opciones": opciones, "responsable": self})

func camina(posicion_destino: Vector2):
	director.encolar('caminar', {"posicion_destino": posicion_destino})
	
func guardar_resultado_examen(resultado: String):
	registrar_hito("el_resultado_del_examen_fue:" + resultado)
	
func resultado_con_el_que_aprobo() -> String:
	var resultados_posibles = ["excelente", "nota_buena", "nota_minima", "reprobado"]
	for resultado in resultados_posibles:
		if ya_ocurrio_que("el_resultado_del_examen_fue:" + resultado):
			return resultado
	return ""
