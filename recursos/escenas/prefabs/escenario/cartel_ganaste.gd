extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func animar():
	$AnimationPlayer.play("aparicion")

func _on_TextureButton_button_up():
	get_tree().change_scene("res://recursos/escenas/prefabs/escenario/Portada.tscn")
