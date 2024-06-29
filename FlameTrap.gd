extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D


var is_on : bool = false


func _ready():
	collision_shape_2d.disabled = true


func activate_fire():
	is_on = true
	animated_sprite_2d.play("on")
	await get_tree().create_timer(0.7).timeout
	collision_shape_2d.disabled = false
	await get_tree().create_timer(0.9).timeout
	collision_shape_2d.disabled = true
	is_on = false
