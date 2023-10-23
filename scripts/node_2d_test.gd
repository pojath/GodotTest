extends Node2D



var count: int = 0

func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		# Print to Output window
	#if (Input.is_key_pressed(KEY_F)):
		pass
#	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
#		print("Left mouse button pressed!")
	if (Input.get_mouse_button_mask() == 0x03):
		print("Left and right mouse buttons pressed!")
	if (Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	return delta
