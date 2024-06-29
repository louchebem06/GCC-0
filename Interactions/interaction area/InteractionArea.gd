extends Area2D
class_name InteractionArea

@onready var label = $Label
@onready var spike = $"../../Spike"
var player_in_area = false


func _ready():
	label.hide()
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)


func _on_body_entered(body):
	label.show()
	if body.is_in_group("Player"):
		player_in_area = true


func _on_body_exited(body):
	label.hide()
	if body.is_in_group("Player"):
		player_in_area = false


func _process(delta):
	if player_in_area && Input.is_action_just_pressed("interact"):
		spike.activate_spikes()

