extends Area2D

var rightSpawnPoint = null
var new_position = Vector2()

func _ready():
	rightSpawnPoint = get_node("%RightSpawnPoint")
	new_position = Vector2(rightSpawnPoint.position.x, rightSpawnPoint.position.y)
	



#var new_position = rightSpawnPoint.transform.origin


func _on_body_entered(body):
	print(rightSpawnPoint)
	print (new_position)
	print(body.position) 
	body.transform.origin = new_position
