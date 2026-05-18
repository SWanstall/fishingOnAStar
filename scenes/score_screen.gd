extends Node2D


@onready var fish_meat_score = $FishMeatScore


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func scoring(score: int):
	fish_meat_score.text = str("Fish meat: %s" % score)
