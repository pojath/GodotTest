extends RigidBody2D

var left_position = Vector2()
var right_position = Vector2()
var velocity = Vector2.ZERO
const SPEED = 300.0
var spawnPointRef = null
signal testingSignal()
var weDropped
var line2D = null


@onready var myName = self.name

func _ready():
	print (myName)
	weDropped = false
	spawnPointRef = get_parent().get_parent()
	connect("testingSignal", Callable(spawnPointRef, '_on_my_custom_signal'))
	
	var rightSpawnPoint = get_node('../../../StaticBody2D2/RightSpawnPoint')
	var leftSpawnPoint = get_node('../../../StaticBody2D2/LeftSpawnPoint')
	line2D = get_node('./Line2D')

	left_position = Vector2(leftSpawnPoint.global_position.x, leftSpawnPoint.global_position.y)
	right_position = Vector2(rightSpawnPoint.global_position.x, rightSpawnPoint.global_position.y)


func _physics_process(delta):
	if !weDropped:
		leftyrightymovement()
	else:
		velocity = Vector2.ZERO
		gravity_scale = 1

	if Input.is_action_pressed("ui_accept"):
		weDropped = true
		spawnPointRef.playerInfo(weDropped)
		if is_instance_valid(line2D):
			line2D.queue_free()
		
	var collision = move_and_collide(velocity * delta)
	
	if collision:

		var fruitName = collision.get_collider().name
		var fruitNode = collision.get_collider()
		
		
		if collision.get_collider_shape().name == "CollisionShapeLeft":
			global_position = right_position
		elif collision.get_collider_shape().name == "CollisionShapeRight":
			global_position = left_position
		elif myName == fruitName:
			fruitCombiner(collision, fruitName, fruitNode)
			gravity_scale = 0
#
func leftyrightymovement():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
func fruitCombiner(collision, fruitName, fruitNode):
	var pos1 = self.global_position
	var pos2 = collision.get_collider().global_position
	var pos3 = Vector2()
	pos3 = (pos1 + pos2)/2
	var deleteFruit = fruitNode
	var newFruit = str(fruitName)
	
	#get the length of the string
	var newFruitLength = newFruit.length() - 1
	
	if newFruitLength > 0:
		var minFruit = 1
		var maxFruit = 5
	
		#get all the characters except for the last one
		var fruitTemplateName = newFruit.left(newFruitLength)
		
		#get the last character so we can add 1 to it
		var lastCharacter = newFruit[newFruitLength]
		
		#add 1 to it
		var newChar = int(lastCharacter) + 1
		
		#clamp the value
		var clampedFruit = clamp(newChar, minFruit, maxFruit)
		
		#combine it all
		var newerfruit = fruitTemplateName + str(clampedFruit)
		print("the fruit to spawn is: ", newerfruit)
		
		#feed SpawnPoint the # to spawn
		if int(lastCharacter) != 5:
			fruitDeleter(deleteFruit)
			testingSignal.emit(clampedFruit, pos3)
		
func fruitDeleter(fruitNode):
	print("fruit deleter")
	if is_instance_valid(fruitNode):
		print("fruit deleter is working")
		fruitNode.queue_free()
		fkYourself()

	#measure the distance between the two objects
	#figure out which one to instantiate by getting the name and + 1 it.
	#instantiate a new one
	
func weSpawned():
	weDropped = true
	if is_instance_valid(line2D):
		line2D.queue_free()
		
func fkYourself():
	print("go fk yourself")
	if is_instance_valid(self):
		print("go fk yourself is working")
		get_parent().queue_free()
		queue_free()	
