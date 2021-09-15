extends Node2D


var nombre_de_la_region_actual: String = "patio_de_juegos"
var region_actual: Region = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deployar_region_actual()
	
func escena_de_la_region(nombre_de_la_region):
	"res://regiones/{}.tres".format(nombre_de_la_region)
	
func cargar_region_actual():
	assert(
		ResourceLoader.exists(escena_de_la_region(nombre_de_la_region_actual)),
		"No existe la escena: " + nombre_de_la_region_actual
	)
	region_actual = load(escena_de_la_region(nombre_de_la_region_actual))
	
	add_child(region_actual, true)
	call_deferred('cargar_region_actual')
	region_actual.cargar()
	
func descargar_region_actual():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
