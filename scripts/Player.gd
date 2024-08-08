extends KinematicBody


const WALK_SPEED:float = 50.0
const SPRINT_SPEED:float = 50.0


export var speed = 20
export var accel = 10
export var gravity = 50
export var jump = 30

var look_rotation: Vector3 = Vector3.ZERO
onready var head: Spatial = $"%Head"

var move_dir = Vector3.ZERO
var velocity = Vector3.ZERO

var jumping = false
var canjump = true
var max_angle:float = 80.0
var min_angle:float = -80.0

export var sensitivity: float = 0.2

var captured: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	GlobalSignal.connect("start_sliding", self, "_start_sliding")
	GlobalSignal.connect("reset", self, "_reset")
#	GlobalSignal.connect("collider", self, "_collider")
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	captured = true
	

#func _collider():
#
#	if GlobalVariables.can_collide == true:
#		$PlatsCollider.disabled = false
#		print($PlatsCollider.disabled)
#	if GlobalVariables.can_collide == false:
#		$PlatsCollider.disabled = true
#		print($PlatsCollider.disabled)


func _reset():
	gravity = 50
	canjump = true
	GlobalVariables.time = 0

func _start_sliding():
	gravity = 1000
	canjump = false
#	velocity.z = 500
#	velocity.y = -1300


func _physics_process(delta):
	
	head.rotation_degrees.x = look_rotation.x
	rotation_degrees.y = look_rotation.y
#
#	if Input.is_action_pressed("run"):
#		speed = SPRINT_SPEED
#	else:
#		speed = WALK_SPEED
	velocity.y -= gravity * delta
#	if not is_on_floor():
#		velocity.y -= gravity * delta
#	else:
#		velocity.y -= 0.03 * delta
	if Input.is_action_just_pressed("cng_pos") && is_on_floor():
		translation.y = 150
		translation.z = -383.072
		
	
	if is_on_floor():
		$CoyoteTimer.stop()
		canjump = true
	else:
		$CoyoteTimer.start()
	
	
	if Input.is_action_just_pressed("jump") and canjump:
		canjump = false
		jumping = true
		velocity.y = jump
	

	move_dir = Vector3(
		Input.get_axis("left", "right"),0,Input.get_axis("forward", "back")
		).normalized().rotated(Vector3.UP, rotation.y)
	
	velocity.x = lerp(velocity.x, move_dir.x * speed, accel * delta)
	velocity.z = lerp(velocity.z, move_dir.z * speed, accel * delta)
	
#	velocity = move_and_slide(velocity, Vector3.UP, false)
#
	var snap = Vector3.DOWN if not jumping else Vector3.ZERO
	velocity = move_and_slide_with_snap(velocity, snap, Vector3.UP, true)
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if captured:
			captured = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			captured = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if not captured:
		return
	
	if event is InputEventMouseMotion:
		look_rotation.y -= event.relative.x * sensitivity
		look_rotation.x -= event.relative.y * sensitivity
		look_rotation.x = clamp(look_rotation.x, min_angle, max_angle)
		

func _on_CoyoteTimer_timeout():
	canjump = false
