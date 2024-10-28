extends CharacterBody3D


enum Faction { NEUTRAL, ENEMY, ALLY }
enum Race { HUMAN, MONSTER, ANIMAL }

var faction_names = {Faction.NEUTRAL:"Neutral", Faction.ENEMY:"Enemy", Faction.ALLY:"Ally"}
var race_names = {Race.HUMAN:"Human", Race.MONSTER:"Monster", Race.ANIMAL:"Animal"}

@export var animation_player_path: NodePath
@export var alive: bool
@export var nameChar: String
@export var health: float
@export var agility: float
@export var stregth: float
@export var faction: Faction
@export var race: Race
@export var sanity: float
@export var leadership: bool
@export var FORWARD_SPEED = 2.0
@export var BACK_SPEED = 1.0
@export var TURN_SPEED = 0.025


func _init(nameChar: String, health: float, agility: float, stregth: float, faction: Faction, race: Race, sanity: float, leadership: bool, alive: bool) -> void:
	if nameChar or health or agility or stregth or faction or race or sanity or leadership or alive != null:
		self._set_name_char(nameChar)
		self._set_agility(agility)
		self._set_health(health)
		self._set_stregth(stregth)
		self._set_faction(faction)
		self._set_race(race)
		self._set_sanity(sanity)
		self._set_leadership(leadership)
		self._set_alive(true)
		if animation_player_path:
			var anim_player = get_node(animation_player_path)
			if anim_player is AnimationPlayer:
				set_animation_player(anim_player)
	else:
		print("ERROR TRYING TO CREATE CHARACTER (BaseCharacter)")
		
	
func get_name_char():
	return self.nameChar
	
func get_health():
	return self.health

func get_stregth():
	return self.stregth
	
func get_faction():
	return self.faction

func get_agility():
	return self.agility

func get_race():
	return self.race
	
func get_sanity():
	return self.sanity
	
func is_leadership():
	return self.leadership
	
func is_alive():
	return self.alive
	
func _set_name_char(name_char: String):
	self.nameChar = name_char
	
func _set_alive(alive: bool):
	self.alive= alive

func _set_sanity(sanity: float):
	self.sanity = sanity
	
func _set_stregth(stregth: float):
	self.stregth=stregth
	
func _set_agility(agility: float):
	self.agility = agility
	
func _set_faction(faction: Faction):
	self.faction = faction

func _set_race(race: Race):
	self.race = race
	
func _set_health(health: float):
	self.health = health
	
func _set_leadership(leadership: bool):
	self.leadership = leadership
	
func character_movement():
	if Input.is_action_pressed("w") and Input.is_action_pressed("s"):
		velocity.x = 0
		velocity.z = 0
		play_animation("Idle")

	elif Input.is_action_pressed("w"):
		var forwardVector = -Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = -forwardVector * FORWARD_SPEED
		play_animation("Running_A")
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
	

func death():
	self._set_alive(false)

func interact():
	pass
	
func play_animation(animation_name: String) -> void:
	if animation_player and animation_player is AnimationPlayer:
		animation_player.play(animation_name)

func character_base_info():
	return "CharacterName: %s, Health: %f, Agility: %f, Sanity: %f, 
	Strength: %f, Faction: %s, Race: %s, Leadership: %b" % [self.get_name_char(), self.get_health(), self.get_agility(), 
	self.get_sanity(), self.get_stregth(), self.get_faction(), self.get_race(), self.is_leadership()]
