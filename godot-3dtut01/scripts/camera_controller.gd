extends Node3D


@export var h_acceleration := 6.0
@export var v_acceleration := 4.0
@export var mouse_acceleration := 0.005
@export var mouse_rotation_top_limit := 0.8;
@export var mouse_rotation_bottom_limit := -0.5

func _process(delta: float) -> void:
	var joy_input = Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down")
	rotate_by_vector(joy_input * delta * Vector2(h_acceleration, v_acceleration))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_by_vector(event.relative * mouse_acceleration)


func rotate_by_vector(v:Vector2):
	if v.length_squared() == 0: return
	rotation.y -= v.x
	rotation.x = clamp(rotation.x - v.y, mouse_rotation_bottom_limit, mouse_rotation_top_limit)
