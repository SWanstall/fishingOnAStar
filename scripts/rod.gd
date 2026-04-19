extends Sprite2D

var mouse_position = null

@onready var rod = $Rod
@onready var line_2d = $Line2D

@export var hook_scene: PackedScene

var hook2 = preload("res://scenes/hook_2.tscn")
var speed = 200

var prev_pos: Vector2
var velocity: Vector2

var shot = false
var b = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)

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
	
	if Input.is_action_just_released("rmb") and shot == false:
		shoot()
		#shot = true
		#await get_tree().create_timer(0.5).timeout
		#shot = false
		
	if b:
		await get_tree().create_timer(0.1).timeout
		var local_pos_1 = line_2d.to_local(b.global_position)
		#var local_pos_0 = line_2d.to_local(current_pos)
		line_2d.set_point_position(1, local_pos_1)
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
	
	# "Muzzle" is a Marker2D placed at the barrel of the gun.
	var current_pos = rod.global_position
	#var b = hook2.instantiate()
	b.global_position = current_pos
	b.velocity = velocity*0.5
	var points = line_2d.get_point_count()
	get_tree().root.add_child(b)
	if points < 2:
		line_2d.add_point(current_pos, 1)
	line_2d.set_point_position(1, b.global_position)
