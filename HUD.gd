extends CanvasLayer
signal start_game
signal complete

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_score(text):
	$ScoreLabel.text = text
	$ScoreLabel.show()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	$Message2.show()
	
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(2), "timeout")
	$Message2.hide()
	$StartButton.show()
	show_score("0/10 Monsters Slayed")

func update_score(score):
	$ScoreLabel.text = str(score)+"/10 Monsters Slayed"
	if(score == 10):
		emit_signal("complete")
		$Message2.text = "LEVEL IS COMPLETE"
		$Message2.show()
		yield(get_tree().create_timer(2), "timeout")
		$PopUpTimer2.start()
		$WaveOneCompPopup.popup()
func _on_StartButton_pressed():
	$StartButton.hide()
	$PopUpTimer.start()
	$StartPopup.popup()
	
func _on_MessageTimer_timeout():
	$Message.hide()


func _on_PopUpTimer_timeout():
	$StartPopup.hide()
	emit_signal("start_game") # Replace with function body.



func _on_PopUpTimer2_timeout():
	$WaveOneCompPopup.hide() # Replace with function body.
