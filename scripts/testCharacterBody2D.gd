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
		print(velocity.y)
	if can_move:
		pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		can_move = false
		apply_gravity = true

