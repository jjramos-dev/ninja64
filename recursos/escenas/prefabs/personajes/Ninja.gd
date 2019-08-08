extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity
export var speed= 20.0
export var g=10
export var jump_power=10

var derecha=true

var jumping_amount=0
var state
enum Estados{idle, walking,jumping, falling,shooting,died}

var disparo
var previousTime=-1

export var periodo_entre_disparos=500

#signal ninja_hit


# Called when the node enters the scene tree for the first time.
func _ready():
	disparo = load("res://recursos/escenas/prefabs/objetos/Disparo.tscn")
	state=Estados.idle
	
func get_input():
	
	# Detect up/down/left/right keystate and only move when pressed.

	match state:
		Estados.idle:
			if Input.is_action_pressed('ui_right'):
				velocity.x += 1
				# $Sprite.set_flip_h(false)
	
				if !derecha:
					derecha=true
					scale.x=-1
	
				$AnimationPlayer.play("andando")
				state=Estados.walking
				
			if Input.is_action_pressed('ui_left'):
				velocity.x -= 1
				# $Sprite.set_flip_h(true)
	
				if derecha:
					derecha=false
					scale.x=-1
					
				$AnimationPlayer.play("andando")
				state=Estados.walking
				
			if Input.is_action_pressed('ui_up') and state!=Estados.jumping:
				jumping_amount=jump_power
				$AnimationPlayer.play("saltando")
				print("Saltando")
				state=Estados.jumping	
				
			if Input.is_action_pressed('ui_action'):
				var anim=$AnimationPlayer.current_animation
				$AnimationPlayer.stop()
				$AnimationPlayer.play("disparando")
				$AnimationPlayer.queue(anim)
				disparar()				
				
		Estados.walking:
			if Input.is_action_pressed('ui_right'):
				velocity.x += 1
				
				if !derecha:
					derecha=true
					scale.x=-1
				
				$AnimationPlayer.play("andando")
				state=Estados.walking
			if Input.is_action_pressed('ui_left'):
				velocity.x -= 1
				
				if derecha:
					derecha=false
					scale.x=-1
				
				$AnimationPlayer.play("andando")
				state=Estados.walking
				
			if Input.is_action_pressed('ui_up') and state!=Estados.jumping:
				jumping_amount=jump_power
				$AnimationPlayer.play("saltando")
				# print("Saltando")
				state=Estados.jumping	
				
			if Input.is_action_pressed('ui_action'):
				var anim=$AnimationPlayer.current_animation
				# $AnimationPlayer.stop()
				$AnimationPlayer.queue(anim)
				$AnimationPlayer.play("disparando")
				disparar()		
				
		Estados.jumping, Estados.falling:
			if Input.is_action_pressed('ui_right'):
				velocity.x += 1
				
				if !derecha:
					derecha=true
					scale.x=-1
			
			if Input.is_action_pressed('ui_left'):
				velocity.x -= 1
				
				if derecha:
					derecha=false
					scale.x=-1
				
		#	if Input.is_action_pressed('ui_up') and state!=Estados.jumping:
		#		state=Estados.jumping	
	
			if Input.is_action_pressed('ui_action'):
				var anim=$AnimationPlayer.current_animation
				# $AnimationPlayer.stop()
				$AnimationPlayer.queue(anim)
				$AnimationPlayer.play("disparando")		
				disparar()		
				
		Estados.died:		
			pass
				
func _physics_process(delta):

	velocity = Vector2(0,g-jumping_amount)
	get_input()

	if jumping_amount>0:
		jumping_amount-=1
		
	if velocity.y>0 and (state==Estados.jumping or state==Estados.falling):
		$AnimationPlayer.play("falling")
		state=Estados.falling
		
	velocity = velocity * speed
	
		
	if abs(velocity.x)<0.01 and is_on_floor():
		state=Estados.idle
		$AnimationPlayer.play("parado")
				
	move_and_slide(velocity, Vector2(0,-1))
	

func hurt(valor):
	$"../gui".ninja_hit(valor)
	#emit_signal("ninja_hit")
	
func disparar():
	
	var time=  OS.get_system_time_msecs () 
	
	if time-previousTime>periodo_entre_disparos:
	
		var dis=disparo.instance()
		$"../Origen".add_child(dis)
		dis.position=$pistola.global_position
		
		if !derecha:
			dis.set_direccion_left()
			
		previousTime=time
		
func muere():
	$AnimationPlayer.play("muere")
	desactiva_ninja()
	
	
func desactiva_ninja():

	$CollisionShape2D.disabled=true	
	state=Estados.died
	set_physics_process(false)
	set_process(false)

	collision_mask=0x0
	