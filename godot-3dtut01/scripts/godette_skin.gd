extends Node3D


@onready var move_state_machine = $AnimationTree.get("parameters/move_state_machine/playback")
@onready var attack_state_machine = $AnimationTree.get("parameters/attack_state_machine/playback")
var attacking := false


func set_move_state(state:String) -> void:
	move_state_machine.travel(state)


func play_attack_anim() ->void:
	if attacking: return
	print($SecondAttackTimer.time_left)
	attack_state_machine.travel("Slice" if $SecondAttackTimer.time_left > 0 else  "Chop")
	$AnimationTree.set("parameters/attack_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func toggle_attacking(status: bool) -> void:
	attacking = status


func play_defend_anim(forward:bool) -> void:
	var tween = create_tween()
	tween.tween_method(_defend_delta, 1 - float(forward), float(forward), 0.25)
	


func _defend_delta(value: float) -> void:
	$AnimationTree.set("parameters/shield_blend/blend_amount", value)
