extends Node3D


@export var h_acceleration := 2.0
@export var v_acceleration := 2.0

func _process(delta: float) -> void:
	var joy_input = Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down")
	rotate_by_vector(joy_input * delta * Vector2(h_acceleration, v_acceleration))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_by_vector(event.relative * 0.005)


func rotate_by_vector(v:Vector2):
	if v.length_squared() == 0: return
	rotation.y -= v.x
