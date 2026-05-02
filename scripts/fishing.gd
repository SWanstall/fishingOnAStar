extends Node2D

#signal fishing

@onready var character = $Character
@onready var fish: AnimatedSprite2D = $Fish

var green = Color(0.2,1,0.2,1)
var red = Color(1,0.2,0.2,1)
var blue = Color(1,0.5,0.0,1)

var fish_rarity = 0
var hue = green
var fish_processed = false

var current_biome = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_character_body_2d_fish_rarity_set(rarity_value: Variant) -> void:
	
	print("current biome = %s" % current_biome)
	character.rod_sprite.biome_calldown = current_biome
	
	if current_biome == 0:
		if rarity_value >= 60 and rarity_value < 80:
			hue = red
		elif rarity_value >= 80:
			hue = blue
		else:
			hue = green
		
		#print("fish rarity = %s" % rarity_value)
		
		fish.modulate = hue
		fish.animation = "green_slime"
		fish.play()
		
	elif current_biome == 1:
		fish.modulate = Color(1,1,1,1)
		print("medium depth fish")
		fish.animation = "purple_slime"
		fish.play()
	else:
		fish.modulate = Color(1,1,1,1)
		fish.animation = "coin"
		print("Deep fish")
		fish.play()


func _on_character_fish_landed() -> void:
	fish.visible = true


func _on_character_fish_processed() -> void:
	fish_processed = true
	fish.visible = false


func _on_water_area_body_entered(_body):
	#print("FISHING! signal sent")
	character.is_fishing()


func _on_water_area_body_exited(_body):
	#print("body exited")
	character.is_not_fishing()


func _on_biome_biome_entered(biome):
	current_biome = biome
	print(current_biome)


func _on_biome_2_biome_entered(biome):
	current_biome = biome
	print(current_biome)


func _on_biome_3_biome_entered(biome):
	current_biome = biome
	print(current_biome)
