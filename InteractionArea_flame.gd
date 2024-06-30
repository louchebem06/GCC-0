extends Area2D
class_name InteractionArea_flame

@onready var flame_trap = $"../../FlameTrap"
@onready var label_flame = $Label_flame
var player_in_flame_area = false

func _ready():
	#label_flame.hide()
	connect("body_entered", _on_body_flame_entered_)
	connect("body_exited", _on_body_flame_exited_)


func _on_body_flame_entered_(body):
	label_flame.show()
	if body.is_in_group("Player"):
		print("test1")
		player_in_flame_area = true


func _on_body_flame_exited_(body):
	label_flame.hide()
	if body.is_in_group("Player"):
		player_in_flame_area = false



func _process(delta):
	if player_in_flame_area && Input.is_action_just_pressed("interact"):
		flame_trap.activate_flame()




