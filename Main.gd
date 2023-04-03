extends Node

export(PackedScene) var mob_scene
var score
var mob_count = 0
onready var spawnPos = $Path2D/PathFollow2D.position
#onready 	var path_follow = $MobPath/MobSpawnLocation

var hostage = preload("res://Hostage.tscn")
var hostage1 = hostage.instance()
var hostage2 = hostage.instance()
var hostage3 = hostage.instance()
var hostage4 = hostage.instance()
func _ready():
	pass
	#randomize()
	
func game_over():
	$Player.shootAllow = false
	$AlarmTimer.stop()
	$AlarmLight.set_enabled(false)
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	$Music.play()
	$Player.shootAllow = true
	get_tree().call_group("damageable", "queue_free")
	score = 0
	mob_count = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	hostage1.position = Vector2(300,400)
	hostage2.position = Vector2(350, 400)
	hostage3.position = Vector2(400, 400)
	hostage4.position = Vector2(450, 400)
	add_child(hostage1)
	add_child(hostage2)
	add_child(hostage3)
	add_child(hostage4)
	$HUD.show_message("Get Ready")
	
	var mob1 = mob_scene.instance()
	var mob2 = mob_scene.instance()
	var mob3 = mob_scene.instance()
	var mob4 = mob_scene.instance()
	mob1.position = Vector2(575, 150)
	#mob1.velocity.x = 0
	mob1.get_node("AnimatedSprite").flip_h = true
	mob2.position = Vector2(625, 150)
	#mob2.velocity.x = 0
	mob3.position = Vector2(625, 225)
	#mob3.velocity.x = 0
	mob4.position = Vector2(575, 225)
	#mob4.velocity.x = 0
	mob4.get_node("AnimatedSprite").flip_h = true
	add_child(mob1)
	add_child(mob2)
	add_child(mob3)
	add_child(mob4)

func _on_MobTimer_timeout():
	# Create a Mob instance and add it to the scene.
	if mob_count > 5:
		pass
	else:
		var mob = mob_scene.instance()
		var new_path = PathFollow2D.new()
		$Path2D.add_child(new_path)
		new_path.add_child(mob)
		new_path.set_offset(randi())
		mob.connect("area_entered", self, "on_mob_area_entered")
		mob_count += 1

func spawn_item(item_type, item_position):
	if item_type == "Loot":
		if randf() < 0.5:
			var loot = preload("res://LootDrop.tscn")
			var drop = loot.instance()
			drop.global_position = item_position
			get_parent().add_child(drop)
	if item_type == "Gun":
		var gun = preload("res://Gun.tscn").instance()
		gun.global_position = item_position
		get_parent().add_child(gun)


func mob_killed():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$AlarmLight.set_enabled(true)
	$AlarmTimer.start()

func _on_HUD_complete():
	hostage1.play()
	hostage2.play()
	hostage3.play()
	hostage4.play()
	yield(get_tree().create_timer(4), "timeout") # Replace with function body.
	hostage1.stop()
	hostage2.stop()
	hostage3.stop()
	hostage4.stop()


func _on_AlarmTimer_timeout():
	if $AlarmLight.is_enabled() == true:
		$AlarmLight.set_enabled(false)
		$AlarmTimer.start()
	else: 
		$AlarmLight.set_enabled(true)
		$AlarmTimer.start()
