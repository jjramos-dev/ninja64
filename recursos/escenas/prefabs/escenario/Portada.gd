extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#var escena_juego = preload("res://recursos/escenas/prefabs/escenario/EscenarioNuevo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_size(Vector2(320,320))	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()


func _on_BotonPlay_button_up():
	get_tree().change_scene("res://recursos/escenas/prefabs/escenario/EscenarioNuevo.tscn")


func _on_BotonCredits_button_up():
	get_tree().change_scene("res://recursos/escenas/prefabs/escenario/Creditos.tscn")


func _on_Portada_tree_exiting():
	$AudioStreamPlayer.stop()
