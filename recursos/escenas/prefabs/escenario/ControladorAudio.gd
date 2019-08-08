extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var musica_victoria=preload("res://recursos/audio/music/MegaRust.ogg")
onready var musica_derrota=preload("res://recursos/audio/music/InThePast.ogg")
onready var musica_fondo=preload("res://recursos/audio/music/TrainingInTheFire.ogg")

onready var cancion=musica_fondo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($AudioStreamPlayer2D.is_playing() != true):
		$AudioStreamPlayer2D.play(0.0)
	
func play_win():
	cancion=musica_victoria
	$AudioStreamPlayer2D.set_stream(cancion)
	$AudioStreamPlayer2D.play()
	
func play_die():
	cancion=musica_derrota
	$AudioStreamPlayer2D.set_stream(cancion)
	$AudioStreamPlayer2D.play()