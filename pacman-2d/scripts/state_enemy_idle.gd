extends StateEnemy

func enter():
	print('entering idle...')
	pass

func process():
	print('in idle process...')
	pass

func physics_process(_delta):
	print('in idle physics...')
	pass

func exit():
	print('exiting idle...')
	pass
