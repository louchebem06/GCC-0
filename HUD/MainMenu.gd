extends Control

@onready var testos = $".."

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
