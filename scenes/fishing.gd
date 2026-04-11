extends Node2D

@onready var fish: AnimatedSprite2D = $Fish

var green = Color(0.2,1,0.2,1)
var red = Color(1,0.2,0.2,1)
var blue = Color(0.0,1,1,1)

var fish_rarity = 0
var hue = green
var fish_processed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_character_body_2d_fish_rarity_set(rarity_value: Variant) -> void:
	
	if rarity_value >= 60:
		hue = red
	elif rarity_value >= 80:
		hue = blue
	else:
		hue = green
	
	print("fish rarity = %s" % rarity_value)
	
	fish.modulate = hue


func _on_character_fish_landed() -> void:
	fish.visible = true


func _on_fishing_zone_fishing() -> void:
	pass


func _on_character_fish_processed() -> void:
	fish_processed = true
	fish.visible = false
