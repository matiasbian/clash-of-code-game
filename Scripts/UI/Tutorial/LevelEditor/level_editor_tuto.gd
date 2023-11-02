class_name LevelEditorTuto extends TutoScriptBase

@export var original_container:VBoxContainer = VBoxContainer.new()
@export var target_container:VBoxContainer = VBoxContainer.new()
@export var remove_button:Button = Button.new()

var avail_parent
var selec_parent
var play_parent
var i = 0

var action_disabled

var show:Color = Color("ffffff")
var hide:Color = Color("ffffff00")

func _ready():
	for c in original_container.get_children():
		var cloned = c.duplicate(8)
		target_container.add_child(cloned)
		cloned.modulate = hide
	
func _get_dialogs():
	return [
		{
			"dialog": "¡Hola!"
		},
		{
			"dialog": "¡Bienvenido al creador de niveles!"
		},
		{
			"dialog": "Te guiaré en el proceso de crear un nivel"
		},
		{
			"dialog": "En esta casilla debes ingresar el n° de nivel que deseas crear.",
			"action": play_step
		},
		{
			"dialog": "Ten en cuenta que no se puede sobreescribir un nivel ya existente."
		},
		{
			"dialog": "En esta casilla debes ponerle un nombre al nivel creado.",
			"action": play_step
		},
		{
			"dialog": "Aquí puedes agregar un texto que se mostrará en un cuadro de dialogo al iniciar el nivel.",
			"action": play_step
		},
		{
			"dialog": "Es muy útil cuando se desea comunicar al usuario algún tipo de información inicial",

		},
		{
			"dialog": "En esta casilla se debe ingresar la cantidad de acciones mínimas para ganar el nivel",
			"action": play_step
		},
		{
			"dialog": "Este valor se usa para calcular la cantidad de estrellas que obtendrá el jugador"
		},
		{
			"dialog": "En esta grilla se ingresan las celdas que tendrá el nivel.",
			"action": play_step
		},
		{
			"dialog": "Se necesita al menos: Una celda de START y una de FINISH para poder crear el nivel."
		},
		{
			"dialog": "Las celdas de movimiento, salto, IF, FOR y sacar son totalmente opcionales."
		},
		{
			"dialog": "Una vez que termines el nivel, presiona GUARDAR y el nivel ya estará disponible para jugar.",
			"action": play_step
		},
		{
			"dialog": "Por ultimo, con este botón puedes eliminar niveles que hayas creado.",
			"action": remove_step
		},
		{
			"dialog": "Aquí termina el tutorial. ¡Gracias por tu atención!",
			"action": final_step
		}
	]

func remove_step():
	target_container.get_child(i -1).modulate = hide
	remove_button.visible = true
	
func final_step():
	remove_button.visible = false
	StoredData.save("TutoLevelEditor", true)

func play_step():
	target_container.get_child(i).modulate = show
	if (i > 0):
		target_container.get_child(i -1).modulate = hide
	i += 1	
