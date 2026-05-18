extends Node2D

#signal fishing

@onready var character = $Character
@onready var fish: AnimatedSprite2D = $Fish
@onready var fish_meat = $FishMeat
@onready var music: AudioStreamPlayer = $AudioStreamPlayer
@onready var score_screen = $ScoreScreen

@onready var sky_night = $SkyNight
@onready var sky_dusk = $SkyDusk
@onready var sky_dawn = $SkyDawn
@onready var sky_daylight = $SkyDaylight


var green = Color(0.2,1,0.2,1)
var red = Color(1,0.2,0.2,1)
var blue = Color(0,1,1,1)
var orange = Color(1,0.5,0,1)
var clear = Color(1,1,1,1)

var fish_rarity = 0
var hue = green
var fish_processed = false

var current_biome = null

var fish_meat_score: int = 0

enum Day_night_periods {DAWN, DAY, DUSK, NIGHT}
var day_stage = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fish_meat.text = str("Fish meat: %s" % fish_meat_score)
	fish_meat.set("theme_override_colors/font_color", orange)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_character_body_2d_fish_rarity_set(rarity_value: Variant) -> void:
	
	print("current biome = %s" % current_biome)
	character.rod_sprite.biome_calldown = current_biome
	
	if current_biome == 0:
		if rarity_value >= 60 and rarity_value < 90:
			hue = clear
			fish.animation = "crab"
			fish_meat_score += 2
		elif rarity_value >= 90:
			hue = clear
			fish.animation = "clownfish"
			fish_meat_score += 3
		else:
			hue = green
			fish.animation = "anchovy"
			fish_meat_score += 1
		
		#print("fish rarity = %s" % rarity_value)
		
		#fish.modulate = hue
		##fish.animation = "anchovy"
		#fish.play()
		
	elif current_biome == 1:
		if rarity_value >= 60 and rarity_value < 90:
			hue = clear
			fish.animation = "surgeonfish"
			fish_meat_score += 2
		elif rarity_value >= 90:
			hue = clear
			fish.animation = "puffer_fish"
			fish_meat_score += 4
		else:
			hue = red
			fish.animation = "anchovy"
			fish_meat_score += 1
		
		#print("medium depth fish")
		#fish.animation = "purple_slime"
		#fish.modulate = hue
		#fish.play()
	else:
		if rarity_value >= 60 and rarity_value < 90:
			hue = clear
			fish.animation = "angelfish"
			fish_meat_score += 1
		elif rarity_value >= 90:
			hue = clear
			fish.animation = "coin"
		else:
			hue = clear
			fish.animation = "catfish"
			fish_meat_score += 2
		#fish.modulate = Color(1,1,1,1)
		#fish.animation = "coin"
		#print("Deep fish")
		#fish.modulate = hue
		#fish.play()
	fish.modulate = hue
	fish.play()


func _on_character_fish_landed() -> void:
	fish.visible = true


func _on_character_fish_processed() -> void:
	fish_processed = true
	fish.visible = false
	fish_meat.text = str("Fish meat: %s" % fish_meat_score)


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


func _on_check_button_toggled(toggled_on: bool) -> void:
	if music.playing == false:
		music.play()
	else:
		music.stop()

func _on_day_night_cycle_timeout():
	if day_stage == 0:
		sky_dawn.visible = true
		sky_daylight.visible = false
		sky_dusk.visible = false
		sky_night.visible = false
		day_stage += 1
		fish_meat.set("theme_override_colors/font_color", Color(0.32, 0, 0.33, 1))
	elif day_stage == 1:
		sky_dawn.visible = false
		sky_daylight.visible = true
		sky_dusk.visible = false
		sky_night.visible = false
		day_stage += 1
		fish_meat.set("theme_override_colors/font_color", clear)
	elif day_stage == 2:
		sky_dawn.visible = false
		sky_daylight.visible = false
		sky_dusk.visible = true
		sky_night.visible = false
		day_stage += 1
		fish_meat.set("theme_override_colors/font_color", orange)
	elif day_stage == 3:
		sky_dawn.visible = false
		sky_daylight.visible = false
		sky_dusk.visible = false
		sky_night.visible = true
		day_stage = 0
		print("end of day")
		fish_meat.set("theme_override_colors/font_color", orange)
		run_score_screen()


func run_score_screen():
	get_tree().paused = true
	score_screen.visible = true
	fish_meat.visible = false
	score_screen.scoring(fish_meat_score)


func _on_score_screen_score_processed():
	get_tree().paused = false
	score_screen.visible = false
	fish_meat_score = 0
	fish_meat.visible = true
	fish_meat.text = str("Fish meat: %s" % fish_meat_score)
	character.is_not_fishing()
