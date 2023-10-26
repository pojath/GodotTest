extends RigidBody2D

var move_speed = 10
var velocity = Vector2.ZERO
var can_move = true
var apply_gravity = false
var axis = Vector2.ZERO
var hasDropped = null

var MAX_SPEED = 300
var FRICTION = 100

@export var right_position = Vector2()
@export var left_position = Vector2()

@onready var rightSpawnPoint = get_node("%RightSpawnPoint")
@onready var leftSpawnPoint = get_node("%LeftSpawnPoint")

func _ready():
	left_position = Vector2(leftSpawnPoint.global_position.x, leftSpawnPoint.global_position.y)
	right_position = Vector2(rightSpawnPoint.global_position.x, rightSpawnPoint.global_position.y)


@onready var parent_node = get_parent()

func _physics_process(delta):
	if can_move:
		move(delta)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		gravity_scale = 1
		velocity = Vector2(0,0)
		can_move = false
		apply_gravity = true
		hasDropped = true
		parent_node.get_parent().playerInfo(hasDropped)
		hasDropped = false

func get_input_axis():
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()
#	if axis == Vector2.ZERO:
#		apply_friction(FRICTION * delta)
#	else:

	velocity = axis * move_speed
	
	velocity = move_and_collide(velocity)
	if velocity:
		print (velocity.get_collider().name)
	#apply_movement(axis * move_speed * delta)

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)

