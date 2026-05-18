extends Node2D


@onready var fish_meat_score = $FishMeatScore

signal score_processed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func scoring(score: int):
	fish_meat_score.text = str("Fish meat: %s" % score)


func _on_button_pressed():
	score_processed.emit()
	#get_tree().paused = false
	#get_tree().reload_current_scene()
