extends Node2D

var fish_rarity = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_character_body_2d_fish_rarity_set() -> void:
	fish_rarity = randf_range(1.0, 100.0)
	print("fish_rarity = %s" % fish_rarity)


#func _on_fishing_zone_fishing() -> void:
	#fish_rarity = randf_range(1.0, 100.0)
	#print("fish_rarity = %s" % fish_rarity)
