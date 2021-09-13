extends WATTest

const Scheduler = preload("res://cola_de_comandos/scheduler.gd")

var yyy
var numero

func pre():
	numero = 0
	yyy = nuevo_yyy()
	
func nuevo_yyy():
	return Scheduler.new()
	
func test_al_encolar_un_comando_y_avanzar_un_step_se_ejecuta_ese_comando():
	yyy.registrar_nuevo_comando('sumar_3', self)
	yyy.encolar('sumar_3')
	asserts.is_true(numero == 0)
	yyy.ejecutar_siguiente_comando()
	asserts.is_true(numero == 3)
	
func test_al_encolar_varios_comandos_se_ejecutan_en_orden():
	yyy.registrar_nuevo_comando('sumar_1', self)
	yyy.registrar_nuevo_comando('sumar_3', self)
	yyy.encolar('sumar_1')
	yyy.encolar('sumar_3')
	asserts.is_true(numero == 0)
	yyy.ejecutar_siguiente_comando()
	asserts.is_true(numero == 1)
	yyy.ejecutar_siguiente_comando()
	asserts.is_true(numero == 4)
	
func test_tratar_de_avanzar_un_step_mientras_el_anterior_no_termino_es_un_error():
	yyy.registrar_nuevo_comando('colgarse', self)
	yyy.registrar_nuevo_comando('sumar_1', self)
	yyy.encolar('colgarse')
	yyy.encolar('sumar_1')
	asserts.is_true(numero == 0)
	yyy.ejecutar_siguiente_comando()
	asserts.is_true(numero == 9000)
	push_warning("Debe fallar")
	asserts.is_false(yyy.ejecutar_siguiente_comando())
	asserts.is_true(yyy.obtener_comando_que_se_esta_ejecutando() == 'colgarse')

func test_ejecuta_los_tests_uno_tras_otro_salvo_que_este_pausado():
	yyy.registrar_nuevo_comando('sumar_3', self)
	yyy.registrar_nuevo_comando('colgarse', self)
	yyy.encolar('sumar_3')
	yyy.encolar('sumar_3')
	yyy.encolar('colgarse')
	yyy.encolar('sumar_3')
	asserts.is_true(numero == 0)
	yyy._process(1)
	asserts.is_true(numero == 9006, 'deberia haber sumado solo los primeros dos y luego colgarse')
	asserts.is_true(yyy.obtener_comando_que_se_esta_ejecutando() == 'colgarse')
	yyy.termino_la_ejecucion_del_comando()
	yyy._process(1)
	asserts.is_true(numero == 9009, "deberia haber sumado el 3 que faltaba")
	assert(numero == 9009)
	yyy.pausar()
	yyy.encolar('sumar_3')
	yyy._process(1)
	asserts.is_true(numero == 9009)
	assert(numero == 9009)
	yyy.reanudar()
	yyy._process(1)
	asserts.is_true(numero == 9012)
	assert(numero == 9012)
	
func sumar_3(scheduler):
	numero += 3
	scheduler.termino_la_ejecucion_del_comando()

func sumar_1(scheduler):
	numero += 1
	scheduler.termino_la_ejecucion_del_comando()

func colgarse(scheduler):
	numero += 9000
