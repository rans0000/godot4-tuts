extends Node
class_name  StateMachine

var states: Dictionary = {}
@export var current_state:State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
	print(states)
	if(current_state):
		current_state.enter()


func _process(_delta: float) -> void:
	if current_state:
		current_state.process()


func _physics_process(_delta: float) -> void:
	if current_state:
		current_state.physics_process()


func on_child_transition(state:State, _new_state:String):
	if state != current_state:
		return
	
	var new_state = states.get(_new_state.to_lower())
	if(!new_state):
		return
