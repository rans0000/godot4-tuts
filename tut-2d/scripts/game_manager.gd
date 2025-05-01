extends Node

var score = 0
@onready var scoreboard: Label = $HUD/Panel/scoreboard


func increment_points():
	score += 100
	scoreboard.text = 'Score ' + str(score)
