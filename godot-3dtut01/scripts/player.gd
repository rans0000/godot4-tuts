extends CharacterBody3D

@export var jump_height := 2.25
@export var jump_time_to_peak := 0.4
@export var jump_time_to_descent := 0.3
@export var base_speed := 4.0
@export var run_speed := 12.0
@export var acceleration := 2.0
@export var deceleration := 4.0

@onready var camera = $CameraController/Camera3D
@onready var jump_velocity:float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity:float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity:float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
@onready var skin = $GodetteSkin

var movement_input:= Vector2.ZERO
var turning_speed := 12.0
var defend := false:
	set(value):
		if not defend and value:
			skin.play_defend_anim(true)
		if defend and not value:
			skin.play_defend_anim(false)
		defend = value

func _physics_process(delta: float) -> void:
	actor_move(delta)
	actor_jump(delta)
	actor_ability()
	move_and_slide()


func actor_move(delta:float) -> void:
	movement_input = Input.get_vector("left", "right", "forward", "backward").rotated(-camera.global_rotation.y)
	var vel_2d = Vector2(velocity.x, velocity.z)
	
	if movement_input != Vector2.ZERO:
		var max_speed = run_speed if Input.is_action_pressed("run") else  base_speed
		vel_2d += movement_input * max_speed * acceleration * delta
		vel_2d = vel_2d.limit_length(max_speed)
		
		#align model to movement direction
		var target_angle = movement_input.angle() - PI/2
		skin.rotation.y = rotate_toward($GodetteSkin.rotation.y, -target_angle, turning_speed * delta) 
		#$GodetteSkin/AnimationPlayer.current_animation = "Running_B"
		skin.set_move_state('Running')
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed * deceleration * delta)
		skin.set_move_state('Idle')
		
	velocity.x = vel_2d.x
	velocity.z = vel_2d.y


func actor_jump(delta: float) -> void:
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_velocity
		skin.set_move_state('Jump')
	var gravity = jump_gravity if velocity.y > 0 else fall_gravity
	velocity.y -= gravity * delta


func actor_ability() -> void:
	if Input.is_action_just_pressed("ability"):
		skin.play_attack_anim()
	defend = Input.is_action_pressed("block")
