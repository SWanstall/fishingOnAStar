extends CharacterBody2D


var speed = 300
var new_gravity = Vector2(0.0, 980.0) # Original gravity is (0.0, 980.0), change as required

#func get_input():
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#velocity = input_dir * speed

func _physics_process(delta):
	#get_input()
	move_and_slide()
	
	if not is_on_floor():
		#velocity += get_gravity() * delta
		velocity += new_gravity * delta
	
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, speed)
		
	#await get_tree().create_timer(3).timeout
	#queue_free()
