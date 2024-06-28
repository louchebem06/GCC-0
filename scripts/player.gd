extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hitbox = $Hitbox

@export_category("Movement Variables")
@export var move_speed : int = 100
@export var acceleration : int = 1000
@export var deceleration : int = 900

@export_category("Jump Parameters")
@export var jump_force : int = -200
@export var jump_gravity : int = 400
@export var jump_hold_time : float = 0.5
@export var gravity : int = 600
var jump_timer : float = 0
var is_alive : bool = true

var init_pos : Vector2

func _ready():
	init_pos = position

func _physics_process(delta):
	if is_alive:
		var direction = get_horizontal_input()
		handle_movement(direction, delta)
		handle_gravity(delta)
		handle_jump(delta)
		update_animation(direction)

	move_and_slide()

# Sets acceleration and deceleration with move_toward().
func handle_movement(direction, delta):
	if direction:
		velocity.x = move_toward(velocity.x, move_speed * direction, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)

# Used for handle_movement(), nullify joypad's sensibility.
func get_horizontal_input() -> int:
	var left = Input.is_action_pressed("Left")
	var right = Input.is_action_pressed("Right")
	if left && !right:
		return -1
	elif right && !left:
		return 1
	else:
		return 0

# Sets gravity according to jump state.
func handle_gravity(delta):
	if velocity.y < 0:
		velocity.y += gravity * delta
	else:
		velocity.y += jump_gravity * delta

# Sets jump power and timer, depending how long the player press the key.
func handle_jump(delta):
	if Input.is_action_just_pressed("Jump") && is_on_floor():
		velocity.y = jump_force
		jump_timer = 0
	
	if Input.is_action_pressed("Jump") && jump_timer < jump_hold_time:
		jump_timer += delta
	else:
		velocity.y += jump_gravity * delta

# Sets most animations.
func update_animation(direction):
	if direction:
		animated_sprite_2d.flip_h = direction < 0
	
	if is_on_floor():
		if direction:
			if animated_sprite_2d.animation != "run":
				animated_sprite_2d.play("run")
		else:
			if animated_sprite_2d.animation != "idle":
				animated_sprite_2d.play("idle")
	else:
		if velocity.y < 0:
			if animated_sprite_2d.animation != "jump":
				animated_sprite_2d.play("jump")
		else:
			if animated_sprite_2d.animation != "fall":
				animated_sprite_2d.play("fall")

# Death & Respawn
func _on_hitbox_area_entered(area):
	is_alive = false
	velocity.x = 0
	animated_sprite_2d.play("death")
	await get_tree().create_timer(0.9).timeout
	position = init_pos
	is_alive = true
	animated_sprite_2d.play("idle")