extends StateEnemy

func _ready() -> void:
	target = Node2D.new()
	target.position = Vector2(40, 50)

func enter():
	print('entering wander...')
	nav_agent.target_position = target.global_position
	pass

func process():
	print('in wander process...')
	pass

func physics_process(delta):
	print('in wander physics...')
	if !nav_agent.is_target_reached():
		var dir = owner.tolocal(nav_agent.get_next_path_position()).normalized()
		owner.velocity = dir*owner.SPEED  * delta
		owner.move_and_slide()
	pass

func exit():
	print('exiting wander...')
	pass

func goto_idle():
	transitioned.emit(self, 'StateIdle')
