extends Node2D

var spawnCooldown = 2.0  # Set the cooldown time in seconds
var lastSpawnTime = 0.0  # Initialize the last spawn time
var hasDropped = null
var twoSecondsPassed = 0.0
var canSpawn = null
var elapsedTime = 0.0

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
	var scene_instance = load("res://scenes/Player2.tscn")
	var instance = scene_instance.instantiate()
	add_child(instance)
	elapsedTime = 0
	instance.connect("player_collision", self, "_on_player_collision")

