extends Camera2D
const CAMERA_ZOOM_DEFAULT = Vector2(1.0, 1.0)
const CAMERA_ZOOM_SPEED = Vector2(1.0, 1.0)
const CAMERA_ZOOM_MIN = Vector2(0.6, 0.6)
const CAMERA_ZOOM_MAX = Vector2(2.0, 2.0)
const ZOOM_SPEED = 5.0

var pressed = false
var curr_zoom

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	# Simple camera movement
	if(event is InputEventMouseButton):
		if(event.button_index == MOUSE_BUTTON_RIGHT and event.pressed): # When Right click is pressed
			pressed = true
		elif(event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed): # When Right click is released
			pressed = false
	elif(event is InputEventMouseMotion and pressed):
		position -= event.relative

func _process(delta) -> void:
	# Zoom, currently uses linear interpolation to add a smoothing effect
	curr_zoom = get_zoom()
	if(Input.is_action_just_pressed("Zoom_In")):
		if(curr_zoom <= CAMERA_ZOOM_MAX):	
			var next_value = get_zoom() * (CAMERA_ZOOM_SPEED + CAMERA_ZOOM_DEFAULT)	
			set_zoom(curr_zoom.lerp(next_value, delta * ZOOM_SPEED ))
	elif(Input.is_action_just_pressed("Zoom_Out")):
		if(curr_zoom >= CAMERA_ZOOM_MIN):
			var next_value = get_zoom() / (CAMERA_ZOOM_SPEED + CAMERA_ZOOM_DEFAULT)	
			set_zoom(curr_zoom.lerp(next_value, delta * ZOOM_SPEED ))		
	pass
