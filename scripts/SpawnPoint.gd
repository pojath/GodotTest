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
var newFruit = false
var whichFruit
var pos3 = Vector2()
var possible_fruits = [
	preload("res://FruitTemplates/Fruit1.tscn"),
	preload("res://FruitTemplates/Fruit2.tscn"),
	preload("res://FruitTemplates/Fruit3.tscn"),
	preload("res://FruitTemplates/Fruit4.tscn"),
	preload("res://FruitTemplates/Fruit5.tscn"),
	preload("res://FruitTemplates/Fruit6.tscn"),
	preload("res://FruitTemplates/Fruit7.tscn"),
	preload("res://FruitTemplates/Fruit8.tscn"),
	preload("res://FruitTemplates/Fruit9.tscn")
	]
var scoreToSend
var endGame = false

signal ScoreUpdater
signal GameState



func _ready():
	var canvas = get_node("/root/World/CanvasLayer")
	connect("ScoreUpdater", Callable(canvas, "_update_score"))
	connect("GameState", Callable(canvas, "save_score"))
	
	for i in possible_fruits:
		fruitList.append(i)

	#pick a random fruit from fruitlist
	_load_the_load_zone()
	_move_to_spawn()
	_load_the_load_zone()
	
func _process(delta):
	pass


func _fruit_was_dropped():
	#this is the enter signal function
	$Timer.start()
	


func playerInfo(blah):
	hasDropped = blah


#the main spawner...take the array fruitInChamber and instantiate the 0 index.
func _spawnPlayer():
	elapsedTime = 0

#this signal is sent from rigid player so we can combine fruits...
func _custom_signal(wishFruit, a):
	whichFruit = wishFruit
	scoreToSend = a
	print(whichFruit)
	
	if !newFruit:
		newFruit = true
	else:
		_replace_fruit()
	
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
	
func _load_the_load_zone():
	_find_next_fruit()
	_fruit_maker()
	_move_to_load_zone()


func _on_timer_timeout():
	_move_to_spawn()
	_load_the_load_zone()

func _replace_fruit():
	if newFruit:
		print(scoreToSend)
		ScoreUpdater.emit(scoreToSend)
		newFruit = false
		var instance = fruitList[whichFruit].instantiate()
		add_child(instance)
		instance.global_position = pos3
		instance.gravity_scale = 1
		instance._delete_line()
		
func _end_the_game():
	endGame = true
	GameState.emit()
