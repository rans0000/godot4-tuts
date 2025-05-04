extends Node3D


@onready var move_state_machine = $AnimationTree.get("parameters/move_state_machine/playback")


func set_move_state(state:String) -> void:
	move_state_machine.travel(state)

func play_attack_anim() ->void:
	$AnimationTree.set("parameters/attack_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
