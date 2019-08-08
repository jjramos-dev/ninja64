extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var velocity=2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position.x+=delta*velocity
	
	if position.x>64+32:
		position.x=-64-32
