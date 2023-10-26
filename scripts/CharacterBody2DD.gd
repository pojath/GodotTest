extends CharacterBody2D

var left_position = Vector2()
var right_position = Vector2()

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var spawnPointRef = null
signal testingSignal()

var weDropped

#@onready var rightSpawnPoint = get_node("/World/StaticBody2D2/%RightSpawnPoint")
#@onready var leftSpawnPoint = get_node("/World/StaticBody2D2/%LeftSpawnPoint")

func _ready():
	weDropped = false
	spawnPointRef = get_parent().get_parent()
	connect("testingSignal", Callable(spawnPointRef, '_on_my_custom_signal'))
	
	var rightSpawnPoint = get_node('../../../StaticBody2D2/RightSpawnPoint')
	var leftSpawnPoint = get_node('../../../StaticBody2D2/LeftSpawnPoint')
	
	

	left_position = Vector2(leftSpawnPoint.global_position.x, leftSpawnPoint.global_position.y)
	right_position = Vector2(rightSpawnPoint.global_position.x, rightSpawnPoint.global_position.y)


func _physics_process(delta):
	if !weDropped:
		leftyrightymovement()
	else:
		velocity.y += gravity * delta

	if Input.is_action_pressed("ui_accept"):
		velocity.y += gravity * delta
		weDropped = true
		spawnPointRef.playerInfo(weDropped)
		
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.get_collider_shape().name)
		if collision.get_collider_shape().name == "CollisionShapeLeft":
			global_position = right_position
			testingSignal.emit()
		elif collision.get_collider_shape().name == "CollisionShapeRight":
			global_position = left_position
			testingSignal.emit()
		else:
			pass
	
	move_and_collide(velocity * delta)
#
func leftyrightymovement():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
