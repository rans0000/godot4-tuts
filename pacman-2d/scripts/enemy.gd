extends CharacterBody2D


const SPEED = 300.0
@export var target:Node2D
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	print(target.name)
	state_machine.target = target
