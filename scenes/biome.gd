extends Area2D

enum Biomes {SHALLOW, REGULAR, DEEP}
@export var biome: Biomes

signal biome_entered(biome)
signal biome_exited(biome)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	biome_entered.emit(biome)


func _on_body_exited(body):
	biome_exited.emit(biome)
