extends CharacterBody2D


@export var speed = 100
@export var new_gravity = Vector2(0.0, 980.0) # Original gravity is (0.0, 980.0), change as required
@export var reel_perc = 0.1
@onready var fish = $Fish

var gravity_value = 900.0
var rope_length = 300.0
var tension_strength = 8.0
var reel_speed = 500.0

var rod = null # Called down from rod.gd when spawned
var rod_pos = null
var to_hook = null
var distance = null

var reeling = false
var scrolling = false

func _ready():
	fish.visible = false

#func get_input():
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#velocity = input_dir * speed

func _physics_process(delta):
	#get_input()
	#move_and_slide()
	
	if not is_on_floor():
		#velocity += get_gravity() * delta
		velocity += new_gravity * delta
		
	
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, speed)
		#has_touched_floor = true
		
	#await get_tree().create_timer(3).timeout
	#queue_free()
	if reeling:
		rod_pos = rod.global_position
		to_hook = global_position - rod_pos
		distance = to_hook.length()

		# 1. Apply gravity
		#velocity.y += gravity_value * delta

		# 2. Rope tension (pull toward rod)
		if distance > 0:
			var direction_to_rod = (rod_pos - global_position).normalized()
			velocity += direction_to_rod * distance * delta # * tension_strength

		# 3. Clamp rope length (prevents stretching)
		if distance > rope_length:
			var corrected_pos = rod_pos + to_hook.normalized() * rope_length
			global_position = corrected_pos

		# Remove outward velocity so it doesn't fight the rope
		velocity = velocity.project(to_hook.normalized().orthogonal())

		# 4. Move
		#velocity = move_and_slide(velocity)
		if scrolling:
			if rope_length > distance:
				rope_length = distance
			elif rope_length <= 10:
				rope_length = 10
				scrolling = false
			else:
				#rope_length -= reel_speed * delta
				if rope_length > 150:
					rope_length -= 2 + distance * 0.5 * reel_perc
				else:
					rope_length -= 2 + distance * reel_perc * 2
				#await get_tree().create_timer(0.01).timeout
			#print(rope_length)
			scrolling = false
		# 5. Reel in
		#if is_reeling:
			#rope_length -= reel_speed * delta
	
	move_and_slide()

#func _input(event):
	#if event.is_action_pressed("scroll"):
		#rope_length -= reel_speed * delta
		
#func hook_reel_in(delta):
	#if rope_length > distance:
		#rope_length = distance
	#rope_length -= reel_speed * delta
	#print(rope_length)
	
func scrolling_func():
	scrolling = true
	

func reeling_func():
	reeling = true
