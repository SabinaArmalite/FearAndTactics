extends Camera3D
@export var target: NodePath
@export var rotate_speed: float = 2.0

var tengo_amiguitos = false

func _ready() -> void:
	pass

func change_camera_target(new_target: Node3D) -> void:
	#global_transform.origin devuelve la posicion en coordenadas de la entidad.
	look_at(new_target.global_transform.origin, Vector3.UP)

func _process(delta: float) -> void:
	
	if tengo_amiguitos == false:
		var party_handler = get_tree().get_current_scene().get_node("PartyHandler")
		
		if party_handler:
			#print("PartyHandler encontrado!")
			var important_object = party_handler.party_chars[party_handler.active_character]
			
			if important_object is Node3D:
				change_camera_target(important_object)
		tengo_amiguitos = true

	if target != null:
		var party_handler = get_tree().get_current_scene().get_node("PartyHandler")
		var new_target = party_handler.party_chars[party_handler.active_character]
		

		if new_target != null:
			#print("holiwis")
			var new_target_position = new_target.global_transform.origin
			look_at(new_target_position, Vector3.UP)
		#else:
			#print("Error: new_target es nulo.")
	#else:
		#print("Error: target es nulo.")
