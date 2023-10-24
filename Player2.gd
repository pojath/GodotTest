extends RigidBody2D

var move_speed = 10
var velocity = Vector2.ZERO
var can_move = true
var apply_gravity = false
var axis = Vector2.ZERO
var hasDropped = null

var MAX_SPEED = 300
var FRICTION = 100


func _ready():
	print("imn ready")


@onready var parent_node = get_parent()

func _physics_process(delta):
	if can_move:
		move(delta)
#	move_and_collide(velocity * delta)



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
	#apply_movement(axis * move_speed * delta)

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)
