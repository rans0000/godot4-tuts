extends CharacterBody3D

@export var jump_height := 2.25
@export var jump_time_to_peak := 0.4
@export var jump_time_to_descent := 0.3
@export var base_speed := 8.0
@export var acceleration := 2.0
@export var deceleration := 4.0

@onready var camera = $CameraController/Camera3D
@onready var jump_velocity:float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity:float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity:float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var movement_input:= Vector2.ZERO

func _physics_process(delta: float) -> void:
	actor_move(delta)
	actor_jump(delta);
	move_and_slide()


func actor_move(delta:float) -> void:
	movement_input = Input.get_vector("left", "right", "forward", "backward").rotated(-camera.global_rotation.y)
	#velocity = Vector3(movement_input.x, 0, movement_input.y) * base_speed
	var vel_2d = Vector2(velocity.x, velocity.z)
	
	if movement_input != Vector2.ZERO:
		vel_2d += movement_input * base_speed * acceleration * delta
		vel_2d = vel_2d.limit_length(base_speed)
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed * deceleration * delta)
		
	velocity.x = vel_2d.x
	velocity.z = vel_2d.y


func actor_jump(delta: float) -> void:
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_velocity
	var gravity = jump_gravity if velocity.y > 0 else fall_gravity
	velocity.y -= gravity * delta
