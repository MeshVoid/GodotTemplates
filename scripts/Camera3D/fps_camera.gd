extends Camera3D
# meta-name: Void Particle FPS Camera
# meta-description: Predefined camera rotation for FPS games
# meta-default: true
# meta-space-indent: 4

@onready var camera_position := get_parent()
@onready var camera := self
@export  var sensitivity := 3

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			camera_position.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))
			
	
func _process(delta: float) -> void:
	pass
