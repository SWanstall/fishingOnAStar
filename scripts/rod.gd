extends Sprite2D

var mouse_position = null

@onready var rod = $Rod

@export var hook_scene: PackedScene

var hook2 = preload("res://scenes/hook_2.tscn")
var speed = 200

var prev_pos: Vector2
var velocity: Vector2

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
	
	if Input.is_action_just_pressed("rmb"):
		print(velocity)
		#var hook = hook_scene.instantiate()
#
		#var rod_tip_position = character_body_2d.global_position
#
		## Spawn the mob by adding it to the Main scene.
		#add_child(hook)
	
	if Input.is_action_just_pressed("rmb"):
		shoot()

#
#func start(pos):
	#position = pos
	#show()
	#$CollisionShape2D.disabled = false


func shoot():
	# "Muzzle" is a Marker2D placed at the barrel of the gun.
	var current_pos = rod.global_position
	var b = hook2.instantiate()
	b.global_position = current_pos
	b.velocity = velocity
	get_tree().root.add_child(b)
