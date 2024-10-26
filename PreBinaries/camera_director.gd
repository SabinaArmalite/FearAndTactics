extends Node3D
#cositas del raycast
@onready var raycast = $RayCast3D
@onready var raycast_visualizer = $RaycastVisualizer
#cositas del director
@export var camera_anchor_group: String = "CameraAnchor"
@export var distance_threshold: float = 5.0  # Umbral para el cambio de ancla.
@export var ray_length: float = 100.0  # Longitud máxima del raycast

func _ready() -> void:
# Configura el raycast inicialmente
	raycast.enabled = false
	raycast.target_position = Vector3.ZERO 
	
	var party_handler = get_tree().get_current_scene().get_node("PartyHandler")

	if party_handler:
		return
	else:
		print("PartyHandler no encontrado en _ready()")


func shoot_raycast():


	var party_handler = get_tree().get_current_scene().get_node("PartyHandler")

	if party_handler:
		var active_character = party_handler.party_chars[party_handler.active_character]

		if active_character is Node3D:
			raycast.target_position= raycast.to_local(active_character.global_position)
			raycast.enabled = true  
			raycast.force_raycast_update()

			if raycast.is_colliding() and raycast.get_collider() == active_character:
			#CALCULAR DISTANCIA DE PERSONAJE
			#MANTENER CAMARA
			#print("Personaje en la línea de visión de la cámara en", raycast.global_position)
				return
			else:

				print("Jugador fuera de vista, buscando nuevo ancla.")
				
				var closest_anchor = find_closest_anchor(active_character.global_position)
				if closest_anchor: #TODAVIA NO ENCUENTRA LA ANCHOR
					global_transform.origin = closest_anchor.global_transform.origin
					print("Cámara movida a:", closest_anchor.name)
					
func get_player_position() -> Vector3:
	var player = get_tree().get_current_scene().get_node("PartyHandler").party_chars[get_tree().get_current_scene().get_node("PartyHandler").active_character]
	#print("camaras disponibles: ",camera_anchor_group)
	return player.global_transform.origin

func find_closest_anchor(player_position: Vector3) -> Node3D:
	var closest_anchor = null
	var min_distance = INF

	for anchor in get_tree().get_nodes_in_group(camera_anchor_group):
		if anchor is Node3D:
			var distance = player_position.distance_to(anchor.global_transform.origin)
			if distance < min_distance:
				min_distance = distance
				closest_anchor = anchor

	return closest_anchor

func _process(delta: float) -> void:

		var party_handler = get_tree().get_current_scene().get_node("PartyHandler")
		var player_position = get_player_position()
		var player_is_visible = shoot_raycast()

		if party_handler:
			#print("PartyHandler de la camara encontrado!")
			var important_object = party_handler.party_chars[party_handler.active_character]
			
			if important_object is Node3D:
				shoot_raycast()
