extends Area2D
class_name InteractionArea_spike


@onready var label_spike = $Label_spike
@onready var spike = $"../../../Spike"
var player_in_spike_area = false


func _ready():
	#label_spike.hide()
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	#label_spike.hide()


func _on_body_entered(body):
	label_spike.show()
	if body.is_in_group("Player"):
		print("test_spike")
		player_in_spike_area = true


func _on_body_exited(body):
	label_spike.hide()
	if body.is_in_group("Player"):
		player_in_spike_area = false


func _process(delta):
	if player_in_spike_area && Input.is_action_just_pressed("interact"):
		spike.activate_spikes()

