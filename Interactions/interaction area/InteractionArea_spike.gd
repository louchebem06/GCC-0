extends Node2D
class_name InteractionArea_spike

@onready var label_spike = $spike_button/InteractionArea_spike/Label_spike
@export var spike : Area2D
var player_in_spike_area = false
@onready var interaction_area_spike = $spike_button/InteractionArea_spike


func _ready():
	label_spike.hide()
	interaction_area_spike.connect("body_entered", _on_body_entered)
	interaction_area_spike.connect("body_exited", _on_body_exited)
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

