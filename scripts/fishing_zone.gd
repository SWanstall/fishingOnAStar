extends Area2D

var rod_in_range = false

signal fishing

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rod_in_range == true:
		if Input.is_action_just_pressed("lmb"):
			print("FISHING! signal sent")
			emit_signal("fishing")


func _on_body_entered(body):
	print("Press F for fishing!")
	rod_in_range = true


func _on_body_exited(body):
	print("No fishing for you!")
	rod_in_range = false
