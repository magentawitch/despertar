extends Node


var _comandos_conocidos = {}
var _cola_de_comandos_pendientes = []
var _comando_que_se_esta_ejecutando = null
var _pausado = false

func _process(delta):
	while not _pausado:
		if not hay_comandos_pendientes() or se_sigue_ejecutando_un_comando():
			break
		var salio_bien = ejecutar_siguiente_comando()
		if not salio_bien or se_sigue_ejecutando_un_comando():
			break

func registrar_nuevo_comando(nombre, quien_lo_atiende):
	_comandos_conocidos[nombre] = quien_lo_atiende

func encolar(comando):
	_cola_de_comandos_pendientes.append(comando)
	
func hay_comandos_pendientes():
	return not _cola_de_comandos_pendientes.empty()

func ejecutar_siguiente_comando():
	if se_sigue_ejecutando_un_comando():
		push_error("No se puede ejecutar otro comando hay uno en ejecucion")
		return false
	if not hay_comandos_pendientes():
		push_error("No hay comandos para ejecutar")
		return false
	var comando = _cola_de_comandos_pendientes.pop_front()
	if comando in _comandos_conocidos:
		_comando_que_se_esta_ejecutando = comando
		_comandos_conocidos[comando].call(comando, self)
		return true
	else:
		push_error("Comando desconocido: " + comando)
		return false

func termino_la_ejecucion_del_comando():
	_comando_que_se_esta_ejecutando = null

func se_sigue_ejecutando_un_comando():
	return _comando_que_se_esta_ejecutando != null
	
func obtener_comando_que_se_esta_ejecutando():
	return _comando_que_se_esta_ejecutando

func pausar():
	_pausado = true
	
func reanudar():
	_pausado = false
	
func esta_pausado():
	return _pausado
