extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var spike_collision = $spike_collision


var is_on : bool = false


func _ready():
	spike_collision.disabled = true

 
func activate_spikes():
	is_on = true
	animated_sprite_2d.play("on")
	await get_tree().create_timer(0.7).timeout
	spike_collision.disabled = false
	await get_tree().create_timer(0.9).timeout
	spike_collision.disabled = true
	is_on = false
