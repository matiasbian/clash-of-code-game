class_name UIProcedureFor extends UIProcedureComplex
	
	
func _on_accept():
	super._on_accept()
	
	var asocciated = button_asocciated.get_node("Button")
	asocciated._on_accept(false)
	
