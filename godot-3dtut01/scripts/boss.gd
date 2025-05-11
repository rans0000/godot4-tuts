extends Enemy

const simple_attacks = {
	"slice": "2H_Melee_Attack_Slice",
	"spin": "2H_Melee_Attack_Spin",
	"range": "1H_Melee_Attack_Stab",
}

func _physics_process(delta: float) -> void:
	move_to_player(delta)


func _on_attack_timer_timeout() -> void:
	var distance = position.distance_to(player.position)
	if distance < melee_attack_radius:
		meele_attack_animation()
	elif distance < range_attack_radius:
		range_attack_animation()


func range_attack_animation() -> void:
	stop_movement(1.5, 1.5)
	attack_animation.animation = simple_attacks["range"]
	$AnimationTree.set("parameters/attack_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func meele_attack_animation() -> void:
	attack_animation.animation = simple_attacks["slice" if rng.randi() % 2 else "spin"]
	$AnimationTree.set("parameters/attack_oneshot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
