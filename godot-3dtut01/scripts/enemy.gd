extends CharacterBody3D
class_name Enemy

@export var walk_speed := 2.0
@export var notice_radius := 30.0
@export var attack_radius := 15.0
@onready var player:CharacterBody3D = get_tree().get_first_node_in_group("Player")
@onready var move_state_machine:AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/move_state_machine/playback")
@onready var skin = get_node("Skin")
var turnaround_speed := 6.0


func move_to_player(delta: float) -> void:
	if position.distance_to(player.position) > notice_radius: return
	
	var target_direction:Vector3 = (player.position - position).normalized()
	var target_vec2 = Vector2(target_direction.x, target_direction.z)
	var target_angle = -target_vec2.angle() + PI/2
	rotation.y = rotate_toward(rotation.y, target_angle, delta * turnaround_speed)
	
	if position.distance_to(player.position) < attack_radius:
		velocity = Vector3(target_vec2.x, 0, target_vec2.y) * walk_speed
		move_state_machine.travel("Walk")
	else:
		move_state_machine.travel("Idle")
		velocity = Vector3.ZERO
	move_and_slide()
