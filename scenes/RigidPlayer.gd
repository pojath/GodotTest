extends RigidBody2D

var left_position = Vector2()
var right_position = Vector2()
var velocity = Vector2.ZERO
const SPEED = 300.0
var spawnPointRef = null
signal testingSignal()
signal enterSignal()
signal endGameSignal()
var weDropped
var line2D = null
var controls = true
var readyToDrop
var fruitID
var mygroup = []
var score = [
	0,10,20,30,40,50,60,70,80,90
	]


@onready var myName = self.name

func _ready():
	body_entered.connect(_on_body_entered)
	readyToDrop = false
	weDropped = false
	spawnPointRef = get_parent()
	
	connect("testingSignal", Callable(spawnPointRef, '_custom_signal'))
	connect("enterSignal", Callable(spawnPointRef, '_fruit_was_dropped'))
	connect("endGameSignal", Callable(spawnPointRef, '_end_the_game'))
	
	var rightSpawnPoint = get_node('../../StaticBody2D2/RightSpawnPoint')
	var leftSpawnPoint = get_node('../../StaticBody2D2/LeftSpawnPoint')
	var ceiling = get_node('../../StaticBody2D2/Ceiling')
	line2D = get_node('./Line2D')

	left_position = Vector2(leftSpawnPoint.global_position.x, leftSpawnPoint.global_position.y)
	right_position = Vector2(rightSpawnPoint.global_position.x, rightSpawnPoint.global_position.y)

	for group in get_groups():
		if not group.begins_with("_"):
			mygroup.push_back(group)

#	print(mygroup)
func _blah():
	print("blah")
	
func _set_name(newName, incrementer):
	self.name = "Fruit" + str(newName) + str(incrementer)
	fruitID = "Fruit" + str(newName)
	
func _not_ready_to_drop():
	readyToDrop = false

func _get_fruit_ID():
	return fruitID

func _ready_to_drop():
	readyToDrop = true

func _input(event):
	if event.is_action_pressed("ui_accept") && readyToDrop:
		enterSignal.emit()
		weDropped = true
		_delete_line()
		
	if event.is_action_pressed("ui_up"):
#		collisionSignal.emit(get_parent())
		pass

func _physics_process(delta):
	if readyToDrop:
		leftyrightymovement()
	if weDropped:
		velocity = Vector2.ZERO
		gravity_scale = 1

	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var fruitName = collision.get_collider()
		var startLetter = str(fruitName).left(1)
		if collision.get_collider_shape().name == "CollisionShapeLeft":
			global_position = right_position
		elif collision.get_collider_shape().name == "CollisionShapeRight":
			global_position = left_position
		elif collision.get_collider_shape().name == "Ceiling":
			print("i touched it")
			endGameSignal.emit()
#		elif startLetter != "S":
#			var enemyFruitID = collision.get_collider().get("fruitID")
#			print("enemyfruitid is: ",enemyFruitID)
#			if self.fruitID == enemyFruitID:
#				fruitCombiner(collision, fruitName)
#				gravity_scale = 0
#
func leftyrightymovement():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _find_fruit_id(blah):
	var fruity = blah.left(6)
	return fruity

#func fruitCombiner(fruitCollision, fruitName):
#	var pos1 = self.global_position
#	var pos2 = fruitCollision.get_collider().global_position
#	var pos3 = Vector2()
#	pos3 = (pos1 + pos2)/2
#
#	var newFruit = str(fruitName)
#
#	#get the length of the string
#	var newFruitLength = newFruit.length() - 1
#	if newFruitLength > 0:
#
#		var minFruit = 1
#		var maxFruit = 9
#
#		#get all the characters except for the last one
#		var fruitTemplateName = newFruit.left(newFruitLength)
#
#		#get the last character so we can add 1 to it
#		var lastCharacter = newFruit[newFruitLength]
#
#
#		#add 1 to it
#		var newChar = int(lastCharacter) + 1
#
#		#clamp the value
#		var clampedFruit = clamp(newChar, minFruit, maxFruit)
#
#		#feed SpawnPoint the # to spawn
#		if int(lastCharacter) != 9:
#			print("emitting signal")
#			var selfFruit = self
#			collisionSignal.emit(selfFruit, fruitName, pos3, fruitID)

func weSpawned():
	weDropped = true
	_delete_line()

func _delete_line():
	controls = false
	if is_instance_valid(line2D):
		line2D.queue_free()

func _hide_line():
	line2D.visible = !line2D.visible
	
func _on_body_entered(body):
	var i = []
	if body.get_groups():
		for group in body.get_groups():
			if not group.begins_with("_"):
				i.push_back(group)
	_does_it_match(i, body)

func _does_it_match(otherfruit, j):
	if otherfruit == mygroup:
		_position_finder(j)
		self.queue_free()
		var a: int = int(str(mygroup)[3])
		testingSignal.emit(a, score[int(str(mygroup)[3]) + 1])

func _position_finder(k):
	var pos1 = self.global_position
	var pos2 = k.global_position
	var pos3 = Vector2()
	pos3 = (pos1 + pos2)/2
	spawnPointRef.pos3 = pos3
	
