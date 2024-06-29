extends Area2D

@onready var player = null;
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

var is_held = false
var hover_offset = 0.0
var hover_speed = 2.0
var hover_amplitude = 3.0

var is_thrown = false
@export var throw_velocity = Vector2.ZERO
var throw_speed = 300.0
var falling = 600.0

func _ready():
	animated_sprite_2d.play("burning")
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _process(delta):
	if is_held:
		hover_offset += hover_speed * delta
		var hover = sin(hover_offset) * hover_amplitude
		if player:
			position = player.position + Vector2(0, -30 + hover)
		
		if Input.is_action_just_pressed("Drop"):
			is_held = false
			is_thrown = true
			collision_shape_2d.disabled = false
			var direction = player.facing
			player = null
			throw_velocity = Vector2(direction * throw_speed, -throw_speed / 2)

	if is_thrown:
		throw_velocity.y += falling * delta
		position += throw_velocity * delta

func _on_body_entered(body):
	if !is_thrown:
		player = body
		is_held = true
		collision_shape_2d.disabled = true

func _on_body_exited(body):
	if is_thrown:
		player = null
