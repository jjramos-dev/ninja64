extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocidad=30
var direccion=Vector2(-1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	position+=direccion*velocidad*delta


func _on_DisparoMonstruo_area_entered(area):
	$AnimationPlayer.play("explotar")
	#velocidad=Vector2(0,0)
	print("Explotando...")
	
func set_direction(dir):
	direccion=dir

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="explotar":
		queue_free()


func _on_DisparoMonstruo_body_entered(body):
	
	# Si es el ninja, le quitamos vida:
	if body.get_collision_layer()&0x01: 
		body.hurt(1)
		
	$AnimationPlayer.play("explotar")
	velocidad=Vector2(0,0)
	# print("Explotando...")

