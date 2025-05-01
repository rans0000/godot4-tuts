extends Node
class_name  StateMachine

var states: Dictionary = {}
@export var  current_state:State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_state_transition)
	print(states)
	if(current_state):
		current_state.enter()


func _process(_delta: float) -> void:
	if current_state:
		current_state.process()


func _physics_process(_delta: float) -> void:
	if current_state:
		current_state.physics_process()


func on_state_transition(state:State, new_state_name:String):
	print(state)
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if(!new_state):
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state;
