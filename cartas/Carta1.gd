extends Escena





func _on_CartaCerrada_pressed():
	$CartaAbierta.visible = true 
	$CartaAbierta/Label.visible = true
	$CartaAbierta/Label2.visible = true
	$CartaAbierta/RichTextLabel.visible = true
	
