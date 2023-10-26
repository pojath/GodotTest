extends Area2D

@export var right_position = Vector2()
@export var left_position = Vector2()
@onready var rightSpawnPoint = get_node("%RightSpawnPoint")
@onready var leftSpawnPoint = get_node("%LeftSpawnPoint")

func _ready():
	left_position = Vector2(leftSpawnPoint.global_position.x, leftSpawnPoint.global_position.y)
	right_position = Vector2(rightSpawnPoint.global_position.x, rightSpawnPoint.global_position.y)
	for child in get_children():
		if child is CollisionShape2D:
			#(name of signal, target object, name of function in target object)
			child.connect("xxx", Callable(self, '_on_body_entered'))
			print("connecting the bodies!")
			
func _testFunction():
	print("test function worked")

#var new_position = rightSpawnPoint.transform.origin
func _on_CollisionShape2D_body_entered(body):
	pass

func _on_body_entered(body):
	print("touching a body: ", body.name)
	
#	body.global_position = left_position
#	body.global_position = right_position



func _on_area_entered(area):
	print("area entered")
