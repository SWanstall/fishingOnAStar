extends CharacterBody2D


var speed = 300

#func get_input():
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#velocity = input_dir * speed

func _physics_process(delta):
	#get_input()
	move_and_slide()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
