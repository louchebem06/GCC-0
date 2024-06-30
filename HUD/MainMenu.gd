extends Control

@onready var testos = $".."
@onready var jo_ambiance_sound = $"../jo-ambiance-sound"
@onready var stop_sound = $"stop-sound"

func _ready():
	pass
#multiplayer.get_unique_id()
func _process(delta):
	#var players = testos.get_children().filter(_filterPlayer);
	#for player in players:
		#if player.name.split('_')[1] == str(multiplayer.get_unique_id()):
			#_moveCam(player.camera)
	pass
#
#func _filterPlayer(e):
	#return e.name.split("_")[0] == "Player"
#
#func _moveCam(camera: Camera2D):
	#self.anchors_preset = camera.anchor_mode


func _on_stop_sound_pressed():
	if jo_ambiance_sound.playing:
		stop_sound.text = '🔈'
		jo_ambiance_sound.stop()
	else:
		stop_sound.text = '🔊'
		jo_ambiance_sound.play()
	pass # Replace with function body.
