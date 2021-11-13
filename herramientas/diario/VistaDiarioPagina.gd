extends Control

# Esto huele a que hay que hacer una script base "Entrada.gd" del que estos
# hereden. También parece que ese sería el lugar correcto para todo lo que es
# la lógica de layout del diario.
var EntradaTexto = preload("res://tipos_de_entrada_de_diario/texto.tscn")
var EntradaFoto = preload("res://tipos_de_entrada_de_diario/foto.tscn")

func _ready():
	_limpiar_entradas()

func _limpiar_entradas():
	for c in get_children():
		c.queue_free()

func _instanciar_entrada(tipo):
	return EntradaDeDiario.cargar(tipo)

func recargar_entradas(entradas):
	print("Recargando entradas de pagina")
	_limpiar_entradas()
	for entrada in entradas:
		var node = _instanciar_entrada(entrada['tipo'])
		node.inicializar_con(entrada)
		add_child(node)
	
