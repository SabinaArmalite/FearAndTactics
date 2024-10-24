extends Node
@export var target: NodePath

var party_chars = []
var active_character = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_tree().get_current_scene().get_children():
			# Verificar si el nodo es un CharacterBody3D (o el tipo de nodo que uses para los personajes)
			if child is CharacterBody3D:
				child.add_to_group("players")
				party_chars.push_front(get_tree().get_nodes_in_group("players"))
				print("Añadido " + child.name + " al grupo 'players'")


func _process(delta: float):
	pass

func start_player_turn():
	# Desactiva el control de todos los personajes
	for active_character in party_chars:
		active_character.disable_controls()
	# Activa el control del personaje actual
	party_chars[active_character].enable_controls()
	print("Turno de: " + party_chars[active_character].name)

func next_character():
	# Cambiar al siguiente personaje
	active_character = (active_character + 1) % party_chars.size()
	start_player_turn()