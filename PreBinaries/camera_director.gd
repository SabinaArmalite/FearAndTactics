extends Node3D
#cositas del raycast
@onready var raycast = $RayCast3D
#cositas del director
@export var camera_anchor_group: String = "CameraAnchor"
@export var distance_threshold: float = 5.0  # Umbral para el cambio de ancla.

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
			#MANTENER CAMARA
			#print("Personaje en la línea de visión de la cámara en", raycast.global_position)
				return
			else:
				#print("cambiando camara")
				find_closest_anchor(active_character.global_position)
				change_camera_position()

func find_closest_anchor(player_position: Vector3) -> Node3D:
	var closest_anchor = null
	var min_distance = INF
	var anchors = get_tree().get_nodes_in_group(camera_anchor_group)
	#print("Número de anclas:", anchors.size())

	for anchor in get_tree().get_nodes_in_group(camera_anchor_group): #no se esta ejecutando, que es un `anchor`?
		if anchor is Node3D:
			var distance = player_position.distance_to(anchor.global_transform.origin)
			#print("punto de camara encontrada", anchor)
			if distance < min_distance:
				min_distance = distance
				closest_anchor = anchor
				
		else:
			print("punto de camara no encontrado")
	return closest_anchor

func change_camera_position():
	print("Jugador fuera de vista, buscando nuevo ancla.")

	var active_camera = get_tree().get_current_scene().get_node("Camera000")
	var party_handler = get_tree().get_current_scene().get_node("PartyHandler")
	var active_character = party_handler.party_chars[party_handler.active_character]
	var closest_anchor = find_closest_anchor(active_character.global_position)

	if closest_anchor:
		global_transform = closest_anchor.global_transform # Asignamos toda la transformación del ancla
		active_camera.global_transform = global_transform # asignar LERP
		print("Cámara movida a:", closest_anchor.name, "nueva posición:", global_transform.origin)

func _process(delta: float) -> void:

		var party_handler = get_tree().get_current_scene().get_node("PartyHandler")
		var player_is_visible = shoot_raycast()

		if party_handler:
			#print("PartyHandler de la camara encontrado!")
			var important_object = party_handler.party_chars[party_handler.active_character]
			
			if important_object is Node3D:
				shoot_raycast()
