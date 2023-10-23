extends CharacterBody2D

@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200

var can_move = true
var apply_gravity = false


const GRAVITY = 800.0

@onready var axis = Vector2.ZERO

func _physics_process(delta):
	if apply_gravity:
		velocity.y += GRAVITY * delta
		#print(velocity.y)
	if can_move:
		move(delta)
	move_and_slide()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		velocity.x = 0
		can_move = false
		apply_gravity = true

func get_input_axis():
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
#	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)


