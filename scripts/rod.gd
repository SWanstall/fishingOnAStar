extends Sprite2D

signal stop_fishing

var mouse_position = null

@onready var rod = $Rod
@onready var line_2d = $Line2D

@export var hook_scene: PackedScene
@export var hook_velocity_mod = 0.5

var hook2 = preload("res://scenes/hook_2.tscn")
var speed = 200

var prev_pos: Vector2
var velocity: Vector2

var shot = false
var reeling = false
var reeled_in = false
var scrolling = false
var b = null

var fish_rarity_calldown
var biome_calldown
var green = Color(0.2,1,0.2,1)
var red = Color(1,0.2,0.2,1)
var blue = Color(1,0.5,0.0,1)
var fish_hooked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	if Input.is_action_just_pressed("ui_cancel"):
		reset()
		#if is_instance_valid(b):
			#reeling = false
		
	if is_instance_valid(b):
		if reeling == true:
			b.reeling_func()
			reeling = false
			
		if scrolling == true:
			b.scrolling_func()
			if b.rope_length <= 10:
				reeled_in = true
			else:
				reeled_in = false
			scrolling = false


func _physics_process(delta):
	var current_pos = rod.global_position
	velocity = (current_pos - prev_pos) / delta
	prev_pos = current_pos
	
	#if Input.is_action_just_pressed("rmb"):
		#pass
		#print(velocity)
		#var hook = hook_scene.instantiate()
#
		#var rod_tip_position = character_body_2d.global_position
#
		## Spawn the mob by adding it to the Main scene.
		#add_child(hook)
	
	if Input.is_action_just_pressed("rmb") and fish_hooked == false: #and shot == true:
		reset()
		reeling = false
		scrolling = false
		reeled_in = false
		if is_instance_valid(b):
			b.reeling = false
			b.scrolling = false
	
	if Input.is_action_just_released("rmb") and shot == false and fish_hooked == false:
		#print("shoot")
		shoot()
		#shot = true
		#await get_tree().create_timer(0.5).timeout
		#shot = false
		
	if is_instance_valid(b):
		await get_tree().create_timer(0.1).timeout
		if is_instance_valid(b) and line_2d.get_point_count() > 1:
			var local_pos_1 = line_2d.to_local(b.global_position)
			line_2d.set_point_position(1, local_pos_1)
			line_2d.visible = true
	#if b:
		#await get_tree().create_timer(0.1).timeout
		#var local_pos_1 = line_2d.to_local(b.global_position)
		#line_2d.set_point_position(1, local_pos_1)
		#var local_pos_0 = line_2d.to_local(current_pos)
		#line_2d.set_point_position(0, local_pos_0)
		
		#line_2d.set_point_position(1, b.global_position)
		#print(b.global_position)

#
#func start(pos):
	#position = pos
	#show()
	#$CollisionShape2D.disabled = false


func shoot():
	if not b:
		b = hook2.instantiate()
		b.rod = rod
	
	# "Muzzle" is a Marker2D placed at the barrel of the gun.
	b.scrolling = false
	b.reeling = false
	var current_pos = rod.global_position
	#var b = hook2.instantiate()
	b.global_position = current_pos
	b.velocity = velocity * hook_velocity_mod
	var points = line_2d.get_point_count()
	get_tree().root.add_child(b)
	if points < 2:
		line_2d.add_point(current_pos, 1)
	line_2d.set_point_position(1, b.global_position)
	#var beep = b.get_node("Fish")
	#beep.modulate = Color(1,0.2,0.2,1)


#func _on_character_body_2d_fish_landed():
	#get_tree().root.remove_child(b)
	
	
func reset():
	if is_instance_valid(b):
		#print("reset")
		b.queue_free()
		line_2d.remove_point(1)
		line_2d.visible = false
		#print(line_2d.get_point_count())
		stop_fishing.emit()
		

func fishappear(fish_rarity_from_character):
	if is_instance_valid(b):
		fish_hooked = true
		var fish_on_hook = b.get_node("Fish")
		var hue
		
		#if fish_rarity_from_character >= 60 and fish_rarity_from_character < 80:
			#hue = red
		#elif fish_rarity_from_character >= 80:
			#hue = blue
		#else:
			#hue = green
		#
		##print("fish rarity = %s" % fish_rarity_from_character)
		#
		#fish_on_hook.modulate = hue
		#fish_on_hook.visible = true

		if biome_calldown == 0:
			if fish_rarity_from_character >= 60 and fish_rarity_from_character < 80:
				hue = red
			elif fish_rarity_from_character >= 80:
				hue = blue
			else:
				hue = green
			
			#print("fish rarity = %s" % rarity_value)
			print("hooked fish green slime")
			
			fish_on_hook.modulate = hue
			fish_on_hook.animation = "green_slime"
			fish_on_hook.play()
			fish_on_hook.visible = true
		
		elif biome_calldown == 1:
			print("hooked fish purple slime")
			fish_on_hook.modulate = Color(1,1,1,1)
			#print("medium depth fish")
			fish_on_hook.animation = "purple_slime"
			fish_on_hook.play()
			fish_on_hook.visible = true
		else:
			print("hooked fish coin")
			fish_on_hook.modulate = Color(1,1,1,1)
			fish_on_hook.animation = "coin"
			#print("Deep fish")
			fish_on_hook.play()
			fish_on_hook.visible = true
