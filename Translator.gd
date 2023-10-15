extends Node

var records = preload("res://translations.tsv").records
var current_lang = "ENGLISH"

func set_current_lang(lang):
	current_lang = lang

func translate(translation_id: String) -> String:
	for r in records:
		if r["ID"] == translation_id and r.has(current_lang):
			return r[current_lang]
	push_error("Translation not found for: %s" % translation_id)
	return translation_id


func translate_tree(node: Node):
	translate_node(node)
	for child in node.get_children():
		translate_tree(child)

func translate_node(node: Node):
	if node.is_in_group("already_translated"):
		return
	node.add_to_group("already_translated")
	
	if node is Label:
		node.text = translate(node.text)
		
	if node is Button:
		node.text = translate(node.text)
