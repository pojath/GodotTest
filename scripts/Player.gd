extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
#	var input = Input.get_action_strength("ui_up")
#	apply_central_force(input * Vector2.UP * 1200.0 * delta)
	var dinput = Input.get_action_strength("ui_down")
	apply_central_force(dinput * Vector2.DOWN * 1200.0 * delta)
	
