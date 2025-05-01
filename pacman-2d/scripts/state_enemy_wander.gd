extends State

var timer:Timer;

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", goto_idle)

func enter():
	print('entering wander...')
	timer.start()
	pass

func process():
	print('in wander process...')
	pass

func physics_process():
	print('in wander physics...')
	pass

func exit():
	print('exiting wander...')
	pass

func goto_idle():
	transitioned.emit(self, 'StateIdle')
