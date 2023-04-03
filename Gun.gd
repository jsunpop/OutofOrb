extends Area2D

signal pickup

var inside_area = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed('interact'):
		if inside_area == true:
			emit_signal("pickup")


func _on_Gun_area_entered(area):
	if area.get_name() == "Player":
		inside_area = true
		print("pickup pls")


func _on_Gun_area_exited(area):
	if area.get_name() == "Player":
		inside_area = false


func _on_Gun_pickup():
	$CollisionShape2D.disabled = true
	hide()
	queue_free()
	print("Picked Up!") # Replace with function body.
