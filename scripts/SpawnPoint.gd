extends Node2D

var spawnCooldown = 2.0  # Set the cooldown time in seconds
var lastSpawnTime = 0.0  # Initialize the last spawn time
var hasDropped = null
var twoSecondsPassed = 0.0
var canSpawn = null
var elapsedTime = 0.0
var fruitList = []
var instance = null
var random_fruit_index = null
var nextFruit = null
var fruitLoaded
var fruitToChamber = null
var isLoaded
var fruitInChamber = []
var thefruit = null
var sup2
var fruitDict = {}
var fruitKey = 1
var increments = 0


#signal myCustomSignal

func _ready():
	#load the packed scene
	var scene_instance = preload("res://FruitTemplates/Fruit1.tscn")

	fruitList.append(scene_instance)
	scene_instance = preload("res://FruitTemplates/Fruit2.tscn")

	fruitList.append(scene_instance)
	scene_instance = preload("res://FruitTemplates/Fruit3.tscn")

	fruitList.append(scene_instance)
	scene_instance = preload("res://FruitTemplates/Fruit4.tscn")

	fruitList.append(scene_instance)
	scene_instance = preload("res://FruitTemplates/Fruit5.tscn")

	fruitList.append(scene_instance)
	scene_instance = preload("res://FruitTemplates/Fruit6.tscn")

	fruitList.append(scene_instance)
	scene_instance = preload("res://FruitTemplates/Fruit7.tscn")

	fruitList.append(scene_instance)
	scene_instance = preload("res://FruitTemplates/Fruit8.tscn")

	fruitList.append(scene_instance)
	scene_instance = preload("res://FruitTemplates/Fruit9.tscn")

	fruitList.append(scene_instance)
	
	#pick a random fruit from fruitlist
	_load_the_load_zone()
	_move_to_spawn()
	_load_the_load_zone()
	

func _fruit_was_dropped():
	#this is the enter signal function
	$Timer.start()
	


func playerInfo(blah):
	hasDropped = blah


#the main spawner...take the array fruitInChamber and instantiate the 0 index.
func _spawnPlayer():
	elapsedTime = 0

#this signal is sent from rigid player so we can combine fruits...
func _custom_signal(fruitToSpawn, pos3):
	print("this is a spawn point test signal, we're spawning #: ", fruitToSpawn)
	_fruit_combiner(fruitToSpawn, pos3)
	
func _find_next_fruit():
	var maxFruitIndex = 4
	random_fruit_index = randi_range(0, fruitList.size()-1)
	random_fruit_index = clamp(random_fruit_index, 0, maxFruitIndex)

func _fruit_maker():
	nextFruit = fruitList[random_fruit_index].instantiate()
	nextFruit._set_name(random_fruit_index + 1, increments)
	increments += 1
	add_child(nextFruit)


func _move_to_load_zone():
	nextFruit.global_position = %LoadingZone.global_position
	thefruit = nextFruit
	thefruit._not_ready_to_drop()

func _move_to_spawn():
	nextFruit.global_position = self.global_position
	thefruit._ready_to_drop()
	
	#connect this to a timer
	
#	_load_the_load_zone()
	
func _load_the_load_zone():
	_find_next_fruit()
	_fruit_maker()
	_move_to_load_zone()

func _fruit_combiner(fruitToSpawn, pos3):
	fruitDict.clear()
	if fruitToSpawn >8:
		pass
	print("doing fruit combiner")
	#this is for combining fruits...
	instance = fruitList[fruitToSpawn-1].instantiate()
	instance._set_name(fruitToSpawn, increments)
	increments += 1
	add_child(instance)
	instance.global_position = pos3
	var blah = instance
	blah._not_ready_to_drop()
	blah.weSpawned()

func _on_timer_timeout():
	_move_to_spawn()
	_load_the_load_zone()

func _collision_manager(myFruit, theirFruit, pos3, fruitID):
	print("my fruit is: ", myFruit)
	print("their fruit is: ", theirFruit)
	fruitDict[myFruit] = theirFruit
	print(fruitDict)
	for key in fruitDict:
		if key != null:
			if is_instance_valid(myFruit):
				myFruit.queue_free()
			if is_instance_valid(theirFruit):
				theirFruit.queue_free()
			var number = int(fruitID.right(1)) + 1
			_fruit_combiner(number, pos3)
			

	
	
