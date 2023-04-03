extends PathFollow2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	position.x = 640
	position.y = 272

# Called when the node enters the scene tree for the first time.
func _process(delta):
	set_offset(get_offset() + 15 * delta)
	
