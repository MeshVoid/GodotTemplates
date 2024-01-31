extends CharacterBody3D
# meta-name: Void Particle FPS Controller
# meta-description: Predefined movement for classical FPS games
# meta-default: true
# meta-space-indent: 4


@onready var fps_camera_position = $FPSCameraPosition
@onready var fps_camera = $FPSCameraPosition/FPSCamera

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")



func _physics_process(delta):	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	movement(delta)
	move_and_slide()

func movement(delta):
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_front", "move_back")
	var direction = (fps_camera_position.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
