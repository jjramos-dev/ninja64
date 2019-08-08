extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_ninja_life=6.0
export var max_monstruo_life=20.0

export var ninja_life=0.0
export var monstruo_life=0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	ninja_life=max_ninja_life
	monstruo_life=max_monstruo_life

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func ninja_hit(valor):
	ninja_life-=valor
	if ninja_life<=0:

		ninja_life=0
		# $"../Ninja".muere()
		$AnimationPlayer.play("fin_de_partida_die")
		
	set_ninja_score(ninja_life)

func monstruo_hit(valor):
	monstruo_life-=valor
	if monstruo_life<=0:
		monstruo_life=0
		# triggers death animation
		#matar_monstruo()
		$AnimationPlayer.play("fin_de_partida")
		
	set_monstruo_score(monstruo_life)	

func matar_monstruo():
	$"../Monstruo".muere()

func poner_cartel_win():
	$ganaste.show()
	$ganaste.animar()
	
	$"../ControladorAudio".play_win()

func matar_ninja():
	$"../Ninja".muere()

func poner_cartel_die():
	$ganaste.set_text("You die!")
	$ganaste.show()
	$ganaste.animar()

	$"../ControladorAudio".play_die()
	
func fade():
		$fade.show()
		$AnimationPlayer.play("fadeout")
		
func _on_gui_ninja_hit():
	print ("Ninja hi!!!!")


func set_monstruo_score(life):
	var n_corazones=ceil(3*life/max_monstruo_life)
	
	# print(str(n_corazones)+" "+str(life)+"/"+str(max_monstruo_life))
	
	for i in range(1,4):
		var corazon=get_node("heart-baddie"+str(i))
		
		if i<=n_corazones:
			corazon.show()
		else:
			corazon.hide()
			
func set_ninja_score(life):
	var n_corazones=ceil(3*life/max_ninja_life)
	
	for i in range(1,4):
		var corazon=get_node("heart-guy"+str(i))
		
		if i<=n_corazones:
			corazon.show()
		else:
			corazon.hide()

func volver_a_menu():
	get_tree().change_scene("res://recursos/escenas/prefabs/escenario/Portada.tscn")
	print("Volviendo a menú...")
	
func volver_():
	print("Volc")