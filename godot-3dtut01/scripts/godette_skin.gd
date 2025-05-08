extends Node3D

class_name ActorSkin


@onready var move_state_machine = $AnimationTree.get("parameters/move_state_machine/playback")
@onready var attack_state_machine = $AnimationTree.get("parameters/attack_state_machine/playback")
@onready var extra_animation = $AnimationTree.get_tree_root().get_node('extra_animation')
var attacking := false
var squash_and_stretch := 1.0:
	set(value):
		var negative = 1.0 + (1 - squash_and_stretch) * 0.3
		squash_and_stretch = value
		scale = Vector3(negative, squash_and_stretch, negative)


func set_move_state(state:String) -> void:
	move_state_machine.travel(state)


func play_attack_anim() ->void:
	if attacking: return
	attack_state_machine.travel("Slice" if $SecondAttackTimer.time_left > 0 else  "Chop")
	$AnimationTree.set("parameters/attack_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func play_spellcast_anim() -> void:
	if attacking: return
	extra_animation.animation = "Spellcast_Shoot"
	$AnimationTree.set("parameters/extra_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func toggle_attacking(status: bool) -> void:
	attacking = status


func play_defend_anim(forward:bool) -> void:
	var tween = create_tween()
	tween.tween_method(_defend_delta, 1 - float(forward), float(forward), 0.25)


func _defend_delta(value: float) -> void:
	$AnimationTree.set("parameters/shield_blend/blend_amount", value)


func switch_weapon(is_meele:bool) -> void:
	if(is_meele):
		$Rig/Skeleton3D/RightHandSlot/sword_1handed2.show()
		$Rig/Skeleton3D/RightHandSlot/wand2.hide()
	else:
		$Rig/Skeleton3D/RightHandSlot/sword_1handed2.hide()
		$Rig/Skeleton3D/RightHandSlot/wand2.show()


func get_hit() -> void:
	extra_animation.animation = "Hit_A"
	$AnimationTree.set("parameters/extra_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	$AnimationTree.set("parameters/attack_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)
	attacking = false
