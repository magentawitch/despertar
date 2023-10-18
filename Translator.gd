extends Node

var records = preload("res://translations.tsv").records
var current_lang = "ENGLISH"

func set_current_lang(lang):
	current_lang = lang

# Busca una traducción en el TSV con el mismo ID.
# En caso de que no exista o no sea un id, devuelve el mismo texto.
# Ej:
#  translate("hello_world") -> "Hola mundirijillo :)"
#  translate("Cualquier otra string random") -> "Cualquier otra string random"
func translate(text: String) -> String:
	var translation_id = text.strip_edges()
	for r in records:
		if r["ID"] == translation_id and r.has(current_lang):
			return text.replace(translation_id, r[current_lang])
	push_error("Translation not found for: %s" % translation_id)
	return text

func translate_node(node: Node):
	if node.is_in_group("already_translated"):
		return
	node.add_to_group("already_translated")
	
	if node is Label:
		node.text = translate(node.text)
		
	if node is Button:
		node.text = translate(node.text)

# Traduce todo un arbol o una escena, yendo por cada nodo y traduciendo su contenido.
func translate_tree(node: Node):
	translate_node(node)
	for child in node.get_children():
		translate_tree(child)
