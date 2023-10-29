extends TutoScriptBase

func _get_dialogs():
	return [
		{
			"dialog": "¡Hola!",
			"action":disable_extra_comands
		},
		{
			"dialog": "¡Bienvenido a Clash of Codes!"
		},
		{
			"dialog": "Mi nombre es _____."
		},
		{
			"dialog": "Y seré tu guía durante este tutorial"
		}
	]

func disable_extra_comands():
	print("Disabling...")
