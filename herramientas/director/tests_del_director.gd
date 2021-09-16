extends WATTest

const Director = preload("./Director.gd")

var director
var numero

func pre():
	numero = 0
	director = nuevo_director()
	
func nuevo_director():
	return Director.new()
	
func sumar_3(director, detalles):
	numero += 3
	director.termino_la_ejecucion_de_la_accion()

func sumar_1(director, detalles):
	numero += 1
	director.termino_la_ejecucion_de_la_accion()

func colgarse(director, detalles):
	numero += 9000
	# no avisa
	
func sumar_x(director, detalles):
	numero += detalles['valor_de_x']
	director.termino_la_ejecucion_de_la_accion()

func test_al_encolar_una_accion_y_avanzar_un_step_se_ejecuta_esa_accion():
	director.registrar_nueva_accion('sumar_3', self)
	director.encolar('sumar_3')
	asserts.is_true(numero == 0)
	director.ejecutar_siguiente_accion()
	asserts.is_true(numero == 3)
	
func test_al_encolar_varias_acciones_se_ejecutan_en_orden():
	director.registrar_nueva_accion('sumar_1', self)
	director.registrar_nueva_accion('sumar_3', self)
	director.encolar('sumar_1')
	director.encolar('sumar_3')
	asserts.is_true(numero == 0)
	director.ejecutar_siguiente_accion()
	asserts.is_true(numero == 1)
	director.ejecutar_siguiente_accion()
	asserts.is_true(numero == 4)
	
func test_tratar_de_avanzar_un_step_mientras_el_anterior_no_termino_es_un_error():
	director.registrar_nueva_accion('colgarse', self)
	director.registrar_nueva_accion('sumar_1', self)
	director.encolar('colgarse')
	director.encolar('sumar_1')
	asserts.is_true(numero == 0)
	director.ejecutar_siguiente_accion()
	asserts.is_true(numero == 9000)
	push_warning("Debe fallar")
	asserts.is_false(director.ejecutar_siguiente_accion())
	asserts.is_true(director.la_accion_que_se_esta_ejecutando() == 'colgarse')

func test_ejecuta_los_tests_uno_tras_otro_salvo_que_este_pausado():
	director.registrar_nueva_accion('sumar_3', self)
	director.registrar_nueva_accion('colgarse', self)
	director.encolar('sumar_3')
	director.encolar('sumar_3')
	director.encolar('colgarse')
	director.encolar('sumar_3')
	asserts.is_true(numero == 0)
	director._process(1)
	asserts.is_true(numero == 9006, 'deberia haber sumado solo los primeros dos y luego colgarse')
	asserts.is_true(director.la_accion_que_se_esta_ejecutando() == 'colgarse')
	director.termino_la_ejecucion_de_la_accion()
	director._process(1)
	asserts.is_true(numero == 9009, "deberia haber sumado el 3 que faltaba")
	assert(numero == 9009)
	director.pausar()
	director.encolar('sumar_3')
	director._process(1)
	asserts.is_true(numero == 9009)
	assert(numero == 9009)
	director.reanudar()
	director._process(1)
	asserts.is_true(numero == 9012)
	assert(numero == 9012)
	
func test_se_le_pueden_anadir_detalles_a_las_acciones():
	director.registrar_nueva_accion('sumar_x', self)
	director.encolar('sumar_x', {'valor_de_x': 200})
	asserts.is_true(numero == 0)
	director.ejecutar_siguiente_accion()
	asserts.is_true(numero == 200)
