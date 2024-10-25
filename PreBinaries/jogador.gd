extends CharacterBody3D


const GRAVITY = -9.0
@export var FORWARD_SPEED = 2.0
@export var BACK_SPEED = 1.0
@export var TURN_SPEED = 0.025



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta 


	else:
		# Si estamos en el suelo, reseteamos la velocidad en el eje Y
		velocity.y = 0

	if Input.is_action_pressed("w") and Input.is_action_pressed("s"):
		velocity.x = 0
		velocity.z = 0

	elif Input.is_action_pressed("w"):
		var forwardVector = -Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = -forwardVector * FORWARD_SPEED
		if not is_on_floor():
			velocity.y -= 5

	elif Input.is_action_pressed("s"):
		var backwardVector = Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = -backwardVector * BACK_SPEED
		if not is_on_floor():
			velocity.y -= 5

	#If pressing nothing stop velocity
	else:
		velocity.x = 0
		velocity.z = 0 

	# Rotación izquierda/derecha sobre el eje Y
	if Input.is_action_pressed("a"):
		rotation.y += TURN_SPEED # Girar a la izquierda
	elif Input.is_action_pressed("d"):
		rotation.y -= TURN_SPEED # Girar a la derecha



	elif Input.is_action_pressed("d"):
		rotation.z -= Vector3.ZERO.y + TURN_SPEED #* V_LOOK_SENS
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y -= Vector3.ZERO.y + TURN_SPEED #* M_LOOK_SENS


	move_and_slide()
