extends Area2D

@onready var player = null;
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

@export var is_held = false
@export var hover_offset = 0.0
@export var hover_speed = 2.0
@export var hover_amplitude = 3.0

@export var is_thrown = false
@export var throw_velocity = Vector2.ZERO
@export var throw_speed = 300.0
@export var falling = 600.0
var postorch = null

func _ready():
	animated_sprite_2d.play("burning")
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	if is_held:
		hover_offset += hover_speed * delta
		var hover = sin(hover_offset) * hover_amplitude
		if player && player.is_alive:
			position = player.position + Vector2(0, -30 + hover)
			print("torch pos :", position)
		else:
			position = Vector2(0, -30 + hover)
			print("torch pos :", position)
#		else:
#			position = postorch + Vector2(0, 30 + hover)
		
		if player && Input.is_action_just_pressed("Drop"):
			is_held = false
			is_thrown = true
			var direction = player.facing
			collision_shape_2d.disabled = false
			player = null
			throw_velocity = Vector2(direction * throw_speed, -throw_speed / 2)
			falling = 600.0

	if is_thrown:
		throw_velocity.y += falling * delta
		position += throw_velocity * delta

func _on_body_entered(body):
	if body.name != "TileMap" && !is_thrown:
		player = body
		is_held = true
		collision_shape_2d.disabled = true
	else:
		is_thrown = false
		falling = 0
		throw_velocity.y = 0
		throw_velocity.x = 0
		
func _on_body_exited(_body):
	if is_thrown:
		player = null
