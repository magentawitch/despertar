extends Node
class_name Scheduler, "./Scheduler.icon.png"

# "El Scheduler" necesita un renombre por algo mejor, pero no se me ocurre bien qué
# Una posibilidad es "Director" ya que esta dirigiendo que se hace y cuando

var _comandos_conocidos = {}
var _cola_de_comandos_pendientes = []
var _comando_que_se_esta_ejecutando = null
var _pausado = false

func _ready():
	registrar_comandos_de_nodos_hijos()

func _process(delta):
	while not _pausado:
		if not hay_comandos_pendientes() or se_sigue_ejecutando_un_comando():
			break
		var salio_bien = ejecutar_siguiente_comando()
		if not salio_bien or se_sigue_ejecutando_un_comando():
			break

func registrar_nuevo_comando(nombre, quien_lo_atiende):
	_comandos_conocidos[nombre] = quien_lo_atiende
	
func registrar_comandos_de_nodos_hijos():
	for c in get_children():
		registrar_nuevo_comando(c.name, c)

func encolar(comando: String, detalles:Dictionary={}):
	_cola_de_comandos_pendientes.append([comando, detalles])
	
func hay_comandos_pendientes():
	return not _cola_de_comandos_pendientes.empty()

func ejecutar_siguiente_comando():
	if se_sigue_ejecutando_un_comando():
		push_error("No se puede ejecutar otro comando hay uno en ejecucion")
		return false
	if not hay_comandos_pendientes():
		push_error("No hay comandos para ejecutar")
		return false
	var c = _cola_de_comandos_pendientes.pop_front()
	var comando = c[0]
	var detalles = c[1]
	if comando in _comandos_conocidos:
		var atendedor = _comandos_conocidos[comando]
		_comando_que_se_esta_ejecutando = comando
		atendedor.call(comando, self, detalles)
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
