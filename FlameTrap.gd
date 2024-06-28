extends Area2D

@onready var flame_collision = $flame_collision

#@onready var animated_sprite_2d = $AnimatedSprite2D


var flame_is_on : bool = false


func _ready():
	flame_collision.disabled = true


func activate_flame():
	flame_is_on = true
	#animated_sprite_2d.play("on")
	await get_tree().create_timer(0.7).timeout
	print("test")
	flame_collision.disabled = false
	await get_tree().create_timer(0.9).timeout
	flame_collision.disabled = true
	flame_is_on = false
