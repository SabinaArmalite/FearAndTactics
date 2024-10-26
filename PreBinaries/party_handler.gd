extends Node
@export var target: NodePath

var party_chars = []
var active_character = 0
var can_change_character = false
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
	print(str(party_chars[active_character-1])+ "hola")
	print(str(party_chars[active_character])+"pepe")


func _process(delta: float):
	if party_chars[active_character-1].is_on_floor():
		#print("soy gilipollas en el aire")
		party_chars[active_character-1].set_physics_process(true)
			
		#elif party_chars[active_character - 1].is_on_floor():
			#party_chars[active_character - 1].set_physics_process(false)
		for char in party_chars:
			if char != party_chars[active_character] and char.is_on_floor():
				char.set_physics_process(false)
			
			can_change_character = false

	if Input.is_action_just_pressed("DEBUG_CHANGE_CHARACTER"):
		next_character()


func next_character():
	# Desactivar la física del personaje actual
	if party_chars[active_character].is_on_floor():
		party_chars[active_character].set_physics_process(false)

	# Cambiar al siguiente personaje
	active_character = (active_character + 1) % party_chars.size()

	# Activar la física del nuevo personaje
	party_chars[active_character].set_physics_process(true)

	# Llamar la lógica de inicio de turno si es necesario
	#start_player_turn()

	# Activar la flag para indicar que se ha hecho el cambio
	can_change_character = true
