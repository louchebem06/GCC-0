extends Area2D

@onready var player = $"../Player"
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

var is_held = false
var hover_offset = 0.0
var hover_speed = 2.0
var hover_amplitude = 3.0

var is_thrown = false
var throw_velocity = Vector2.ZERO
var throw_speed = 300.0
var falling = 600.0

func _ready():
	animated_sprite_2d.play("burning")
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	if is_held:
		hover_offset += hover_speed * delta
		var hover = sin(hover_offset) * hover_amplitude
		position = player.position + Vector2(0, -30 + hover)
		
		if Input.is_action_just_pressed("Drop"):
			is_held = false
			is_thrown = true
			$CollisionShape2D.set_deferred("disabled", false)
			var direction = player.facing
			throw_velocity = Vector2(direction * throw_speed, -throw_speed / 2)

	if is_thrown:
		throw_velocity.y += falling * delta
		position += throw_velocity * delta

func _on_body_entered(body):
	if body.name == "Player" && !is_thrown:
		is_held = true
		collision_shape_2d.disabled = true
