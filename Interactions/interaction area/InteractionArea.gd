extends Node2D
class_name InteractionArea

@onready var label = $button/Buton_InteractionArea/Label
@export var Trap : Area2D
var player_in_area = false
@onready var buton_interaction_area = $button/Buton_InteractionArea

func _ready():
	label.hide()
	buton_interaction_area.connect("body_entered", _on_body_entered)
	buton_interaction_area.connect("body_exited", _on_body_exited)
	#label.hide()


func _on_body_entered(body):
	label.show()
	if body.is_in_group("Player"):
		print("test")
		player_in_area = true


func _on_body_exited(body):
	label.hide()
	if body.is_in_group("Player"):
		player_in_area = false


func _process(delta):
	if player_in_area && Input.is_action_just_pressed("interact"):
		Trap.activate_trap()
