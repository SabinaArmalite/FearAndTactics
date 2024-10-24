extends CharacterBody3D


const SPEED = 2.5
const JUMP_VELOCITY = 0
const GRAVITY = -9.0
const TERMINAL_VELOCITY = -50.0 # Velocidad máxima de caída
var Vec3Z = Vector3.ZERO
@export var FORWARD_SPEED = 2.0
@export var BACK_SPEED = 1.0
@export var TURN_SPEED = 0.025



func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity.y += GRAVITY * delta 

        if velocity.y < TERMINAL_VELOCITY:
            velocity.y = TERMINAL_VELOCITY
    else:
        # Si estamos en el suelo, reseteamos la velocidad en el eje Y
        velocity.y = 0

    # Handle jump.
    #if Input.is_action_just_pressed("ui_accept"):
    #    velocity.y = JUMP_VELOCITY

    if Input.is_action_pressed("w") and Input.is_action_pressed("s"):
        velocity.x = 0
        velocity.z = 0

    elif Input.is_action_pressed("w"):
        var forwardVector = -Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
        velocity = -forwardVector * FORWARD_SPEED

    elif Input.is_action_pressed("s"):
        var backwardVector = Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
        velocity = -backwardVector * BACK_SPEED

    #If pressing nothing stop velocity
    else:
        velocity.x = 0
        velocity.z = 0 

    # Rotación izquierda/derecha sobre el eje Y
    if Input.is_action_pressed("a"):
        rotation.y += TURN_SPEED # Girar a la izquierda
    elif Input.is_action_pressed("d"):
        rotation.y -= TURN_SPEED # Girar a la derecha

    #  IF turn left WHILE moving back, turn right
    #if Input.is_action_pressed("a") and Input.is_action_pressed("s"):
    #    rotation.z -= Vec3Z.y + TURN_SPEED #* V_LOOK_SENS
    #    rotation.z = clamp(rotation.x, -50, 90)
    #    rotation.y -= Vec3Z.y + TURN_SPEED #* M_LOOK_SENS

    #elif Input.is_action_pressed("a"):
    #    rotation.z += Vec3Z.y - TURN_SPEED #* V_LOOK_SENS
    #    rotation.z = clamp(rotation.x, -50, 90)
    #    rotation.y += Vec3Z.y + TURN_SPEED #* M_LOOK_SENS

    # IF turn right WHILE moving back, turn left
    #if Input.is_action_pressed("d") and Input.is_action_pressed("s"):
    #    rotation.z += Vec3Z.y - TURN_SPEED #* V_LOOK_SENS
    #    rotation.z = clamp(rotation.x, -50, 90)
    #    rotation.y += Vec3Z.y + TURN_SPEED #* M_LOOK_SENS

    elif Input.is_action_pressed("d"):
        rotation.z -= Vec3Z.y + TURN_SPEED #* V_LOOK_SENS
        rotation.z = clamp(rotation.x, -50, 90)
        rotation.y -= Vec3Z.y + TURN_SPEED #* M_LOOK_SENS

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    #var input_dir := Input.get_vector("a", "d", "w", "s")
    #var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    #if direction:
    #    velocity.x = direction.x * SPEED
    #    velocity.z = direction.z * SPEED
    #else:
    #    velocity.x = move_toward(velocity.x, 0, SPEED)
    #    velocity.z = move_toward(velocity.z, 0, SPEED)

    move_and_slide()


func _on_camera_trigger_tree_entered() -> bool:
    pass # Replace with function body.
        
    return 1
func locationofme() -> Vector3:
    return global_transform.origin

func disable_controls():
    # Lógica para desactivar los controles del jugador
    #print("Controles deberian desactivarse pero aun no")
    set_physics_process(false)

func enable_controls():
    # Lógica para activar los controles del jugador
    #print("Controles activados")
    set_physics_process(true)
