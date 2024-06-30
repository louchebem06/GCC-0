extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision = $collision


@export var is_on : bool = false


func _ready():
	collision.disabled = true

 
func activate_trap():
	is_on = true
	animated_sprite_2d.play("on")
	await get_tree().create_timer(0.7).timeout
	collision.disabled = false
	await get_tree().create_timer(0.9).timeout
	collision.disabled = true
	is_on = false
