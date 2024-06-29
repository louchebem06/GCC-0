extends Area2D

@onready var player = $"../Player"
@onready var animated_sprite_2d = $AnimatedSprite2D

var is_held = false
var hover_offset = 0.0
var hover_speed = 2.0
var hover_amplitude = 3.0

func _ready():
	animated_sprite_2d.play("burning")
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	if is_held:
		hover_offset += hover_speed * delta
		var hover = sin(hover_offset) * hover_amplitude
		position = player.position + Vector2(0, -30 + hover)

func _on_body_entered(body):
	if body.name == "Player":
		is_held = true
		$CollisionShape2D.set_deferred("disabled", true)
