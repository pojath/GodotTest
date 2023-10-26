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

signal myCustomSignal

func _ready():
	pass

func _process(delta):
	if hasDropped:
		elapsedTime += delta
	
	#if enough time has passed and there isn't an object already there
	check_cooldown()
#	spawnFunction()

func check_cooldown():
	if elapsedTime >= spawnCooldown && hasDropped:
		#this is where I spawn
		spawnPlayer()
		hasDropped = false

func playerInfo(blah):
	hasDropped = blah


func spawnPlayer():
	#load the packed scene
	var scene_instance = load("res://FruitTemplates/Fruit1.tscn")
	fruitList.append(scene_instance)
	scene_instance = load("res://FruitTemplates/Fruit2.tscn")
	fruitList.append(scene_instance)
	scene_instance = load("res://FruitTemplates/Fruit3.tscn")
	fruitList.append(scene_instance)
	scene_instance = load("res://FruitTemplates/Fruit4.tscn")
	fruitList.append(scene_instance)
	scene_instance = load("res://FruitTemplates/Fruit5.tscn")
	fruitList.append(scene_instance)
	
	random_fruit_index = randi_range(0, fruitList.size()-1)
	
	instance = fruitList[random_fruit_index].instantiate()
	add_child(instance)
	elapsedTime = 0



func _on_my_custom_signal(fruitToSpawn, pos3):
	print("this is a spawn point test signal, we're spawning #: ", fruitToSpawn)
	instance = fruitList[fruitToSpawn-1].instantiate()
	add_child(instance)
	instance.global_position = pos3
	var blah = instance.get_child(0)
	blah.weSpawned()
