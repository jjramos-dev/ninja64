extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var disparo=load("res://recursos/escenas/prefabs/objetos/DisparoMonstruo.tscn")

var mirando_izquierda=true
var direccion=Vector2(-1,0)
var andando=false

export var velocidad=10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Monstruo_body_entered(body):
	# print("recibido disparo "+str(body.get_collision_layer()))
	
	# Recibe disparo, 5º bit:
	if body.get_collision_layer()&0x10: 
		body.queue_free()
		var anim=$AnimationPlayer.current_animation
		
		$AnimationPlayer.play("comiendo")
		$AnimationPlayer.queue(anim)
		
		disparar()
		hurt(1)
				
	# choca con una pared:
	elif body.get_collision_layer()&0x400: 
		cambiar_direccion()

func cambiar_direccion():
	direccion=-direccion
	
	apply_scale(Vector2(-1,1))
	mirando_izquierda=!mirando_izquierda

func disparar():
	var disp=disparo.instance()
	$"../Origen".add_child(disp)
	disp.position=$lanzador.global_position
	disp.set_direction(($"../Ninja".position- disp.position).normalized())
	
	$AnimationPlayer.play("disparado")

func _on_Timer_timeout():
	disparar()
	$AnimationPlayer.play("comiendo")
	andar()
	$DisparoTimer.set_wait_time(rand_range(2,5))

func andar():
	$AnimationPlayer.play("andando")
	$AndandoTimer.start(rand_range(2,5))
	andando=true
	
func _physics_process(delta):
	if andando:
		position.x+=direccion.x*delta*velocidad
		
func _on_AndandoTimer_timeout():
	andando=false
	
func hurt(valor):
	$"../gui".monstruo_hit(valor)

func muere():
	$AnimationPlayer.play("muere")
	desactiva_monstruo()
	
	
func desactiva_monstruo():
	
	set_physics_process(false)
	set_process(false)
	$AndandoTimer.stop()
	$DisparoTimer.stop()
	set_monitoring(false)
	collision_mask=0x0
	