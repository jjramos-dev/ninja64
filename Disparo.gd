extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocity=30
var direccion=Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_direccion_right():
	direccion=Vector2(1,0)
	
func set_direccion_left():
	direccion=Vector2(-1,0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position+=velocity*direccion*delta


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
