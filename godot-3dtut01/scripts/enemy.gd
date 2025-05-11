extends CharacterBody3D
class_name Enemy

@export var walk_speed := 2.0
@export var notice_radius := 30.0
@export var chase_radius := 15.0
@export var melee_attack_radius := 4.0
@export var range_attack_radius := 8.0
@onready var player:CharacterBody3D = get_tree().get_first_node_in_group("Player")
@onready var move_state_machine:AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/move_state_machine/playback")
@onready var skin = get_node("Skin")
@onready var attack_animation:AnimationNodeAnimation = $AnimationTree.get_tree_root().get_node("attack_animation")
var rng = RandomNumberGenerator.new()
const turnaround_speed := 6.0
var speed_modifier := 1.0


func move_to_player(delta: float) -> void:
	var distance = position.distance_to(player.position);
	if distance > notice_radius: return
	
	var target_direction:Vector3 = (player.position - position).normalized()
	var target_vec2 = Vector2(target_direction.x, target_direction.z)
	var target_angle = -target_vec2.angle() + PI/2
	rotation.y = rotate_toward(rotation.y, target_angle, delta * turnaround_speed)
	
	if distance < chase_radius:
		velocity = Vector3(target_vec2.x, 0, target_vec2.y) * walk_speed * speed_modifier
		move_state_machine.travel("Walk")
	else:
		move_state_machine.travel("Idle")
		velocity = Vector3.ZERO
	move_and_slide()


func stop_movement(start_duration: float, end_duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "speed_modifier", 0.0, start_duration)
	tween.tween_property(self, "speed_modifier", 1.0, end_duration)
