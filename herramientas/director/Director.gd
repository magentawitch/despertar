extends Node
class_name Director, "./Director.icon.png"

var _responsables_de_acciones_conocidas = {}
var _cola_de_acciones_pendientes = []
var _accion_que_se_esta_ejecutando = null
var _pausado = false

signal aparecieron_acciones_pendientes
signal se_acabaron_las_acciones_pendientes

func _ready():
	registrar_acciones_a_partir_de_nodos_hijos()

func _process(delta):
	while not _pausado:
		if not hay_acciones_pendientes() or se_sigue_ejecutando_una_accion():
			break
		var salio_bien = ejecutar_siguiente_accion()
		if not salio_bien or se_sigue_ejecutando_una_accion():
			break

func registrar_nueva_accion(nombre_de_la_accion, quien_la_lleva_a_cabo):
	_responsables_de_acciones_conocidas[nombre_de_la_accion] = quien_la_lleva_a_cabo
	
func registrar_acciones_a_partir_de_nodos_hijos():
	for c in get_children():
		registrar_nueva_accion(c.name, c)

func encolar(accion: String, detalles:Dictionary={}):
	if _cola_de_acciones_pendientes.empty():
		emit_signal('aparecieron_acciones_pendientes')
	_cola_de_acciones_pendientes.append([accion, detalles])
	
func hay_acciones_pendientes():
	return not _cola_de_acciones_pendientes.empty()

func ejecutar_siguiente_accion():
	if se_sigue_ejecutando_una_accion():
		push_error("No se puede ejecutar otra accion, hay una en ejecucion")
		return false
	if not hay_acciones_pendientes():
		push_error("No hay acciones para ejecutar")
		return false
	var c = _cola_de_acciones_pendientes.pop_front()
	var accion = c[0]
	var detalles = c[1]
	if accion in _responsables_de_acciones_conocidas:
		var responsable = _responsables_de_acciones_conocidas[accion]
		_accion_que_se_esta_ejecutando = accion
		responsable.call(accion, self, detalles)
		return true
	else:
		push_error("Accion desconocida: " + accion)
		return false

func termino_la_ejecucion_de_la_accion():
	_accion_que_se_esta_ejecutando = null
	if _cola_de_acciones_pendientes.empty():
		emit_signal('se_acabaron_las_acciones_pendientes')

func se_sigue_ejecutando_una_accion():
	return _accion_que_se_esta_ejecutando != null
	
func la_accion_que_se_esta_ejecutando():
	return _accion_que_se_esta_ejecutando

func pausar():
	_pausado = true
	
func reanudar():
	_pausado = false
	
func esta_pausado():
	return _pausado
