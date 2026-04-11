extends CharacterBody2D

var rarity_value = 0.0
signal fish_rarity_set(rarity_value)
signal fish_landed
signal fish_processed

@onready var bobbing_timer = $BobbingTimer
@onready var set_hook_timer = $SetHookTimer
@onready var fishing_ = $"Fishing!"
@onready var hooked_ = $"Hooked!"
@onready var bite_ = $"Bite!"

var can_set_hook = false
var hooked = false
var bobbing = false
var processed = true

const SPEED = 5000.0
const JUMP_VELOCITY = -200

func _ready():
	fishing_.visible = false
	bite_.visible = false
	hooked_.visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_up") and can_set_hook == true and bobbing == true:
		print("HOOKED!")
		hooked = true
		hooked_.visible = true
		bobbing = false
		fishing_.visible = false
		can_set_hook = false
		bite_.visible = false
		processed = false
		emit_signal("fish_landed")
		await get_tree().create_timer(5).timeout
		hooked_.visible = false
		hooked = false
		
	if Input.is_action_just_pressed("ui_down"):
		processed = true
		print("processed = %s" % processed)
		emit_signal("fish_processed")

func _physics_process(delta):
	 #Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	#var erection = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction * SPEED * delta
	#elif erection:
		#velocity.y = erection * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _on_fishing_zone_fishing():
	if bobbing == false and hooked == false and processed == true:
		rarity_value = randf_range(1.0, 100.0)
		fish_rarity_set.emit(rarity_value)
		#emit_signal("fish_rarity_set")
		var bobbing_time = randf_range(2.0, 5.0)
		bobbing = true
		fishing_.visible = true
		bobbing_timer.start(bobbing_time)


func _on_bobbing_timer_timeout():
	print(bobbing)
	print("bobbing timeout----------------------")
	if hooked == false and bobbing == true:
		bite_.visible = true
		fishing_.visible = false
		print("set hook!")
		set_hook_timer.start(2)
		can_set_hook = true



func _on_set_hook_timer_timeout():
	print("set hook timeout----------------------")
	print("hooked = %s" % hooked)
	#print()
	if hooked == false and bobbing == true and can_set_hook == true:
		can_set_hook = false
		bite_.visible = false
		print("Dang, just a nibble...")
		bobbing = false
		fishing_.visible = false
