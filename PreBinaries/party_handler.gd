extends Node
@export var target: NodePath

var party_chars = []
var active_character = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	party_chars.clear()
	
	# Recorre todos los hijos de la escena actual
	for child in get_tree().get_current_scene().get_children():
		# Verifica si el nodo es un CharacterBody3D
		if child is CharacterBody3D:
			child.add_to_group("players")
			# Añade el personaje al array `party_chars`
			party_chars.append(child)
			print("Añadido " + child.name + " al grupo 'players'")
	
	# Verificar si `party_chars` tiene personajes después del ciclo
	if party_chars.size() > 0:
		print("Personajes añadidos:", party_chars.size())
		# Llamar al primer turno o realizar cualquier acción con `party_chars[0]`
		next_character()
	else:
		print("No se encontraron personajes en el grupo 'players'")


func _process(delta: float):
	if !party_chars[active_character].is_on_floor() and Input.is_action_just_pressed("DEBUG_CHANGE_CHARACTER"):
		party_chars[active_character].set_physics_process(true)
	if party_chars[active_character-1].is_on_floor():
		party_chars[active_character-1].set_physics_process(false)
		
	if Input.is_action_just_pressed("DEBUG_CHANGE_CHARACTER"):
		next_character()


func next_character():
	# Cambiar al siguiente personaje
	active_character = (active_character + 1) % party_chars.size()
	party_chars[active_character].set_physics_process(true)
