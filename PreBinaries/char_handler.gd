extends Node

var survivor_list = []

var survivor_alice = {
	"Name": "Alice",
	"Anim": "female",
	"Model": "Alice0",
	"Coll": "Alice0",
	"Origin": "Human",
}

func playable_characters() -> void:
	survivor_list.append(survivor_alice)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
