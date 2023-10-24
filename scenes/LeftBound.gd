extends Area2D

var rightSpawnPoint = null
var new_position = Vector2()

func _ready():
	rightSpawnPoint = get_node("%RightSpawnPoint")
#	new_position = Vector2(rightSpawnPoint.global_position.x, rightSpawnPoint.global_position.y)
	



#var new_position = rightSpawnPoint.transform.origin


func _on_body_entered(body):
	print(rightSpawnPoint)
	print (body.name)
	print(body.position) 
	body.transform.origin = Vector2(0,0)
