extends Node2D

@onready var timer_bar: TextureProgressBar = $Hud/Timer
@onready var timer: Timer = %Timer
@onready var level_complete: Control = $Hud/LevelComplete
@onready var _1_star: TextureRect = $"Hud/LevelComplete/Stars/1star"
@onready var _2_star: TextureRect = $"Hud/LevelComplete/Stars/2star"
@onready var _3_star: TextureRect = $"Hud/LevelComplete/Stars/3star"
@onready var next_level_button: Button = $Hud/LevelComplete/NextLevelButton
@onready var no_stars_label: Label = %NoStarsLabel



var saved = 0
var stars = 0

func _ready() -> void:
	_1_star.hide()
	_2_star.hide()
	_3_star.hide()
	level_complete.hide()
	no_stars_label.hide()
	next_level_button.text = "Next Chapter"
	#SaveSystem.reset_stars()
	#SaveSystem.save_data()

func _process(delta: float) -> void:
	timer_bar.value = timer.time_left
	#print(SaveSystem.get_stars_for_level("level3"))
	#SaveSystem.set_stars_for_level("level3", 0)
		

		
	#prints("total:",SaveSystem.get_total_stars(), "| level1:", SaveSystem.get_stars_for_level("level1"), "| level2:",SaveSystem.get_stars_for_level("level2"), "| level3: ",SaveSystem.get_stars_for_level("level3"), "| saved:", saved, "| stars:", stars)
	if saved == 4:
		timer.set_paused(true)
		
		if timer.time_left > 40:
			stars = 3
		elif timer.time_left > 20:
			stars = 2
		elif timer.time_left > 0:
			stars = 1
		else:
			stars = 0
			
		if SaveSystem.get_stars_for_level("level3") < stars:
			SaveSystem.set_stars_for_level("level3", stars)
		
		var total_stars = SaveSystem.get_total_stars()  
		
		if total_stars < 7:
			next_level_button.disabled = true
			no_stars_label.show()
			no_stars_label.text = "You only have " + str(total_stars) + "/7 stars to get into 2nd chapter!"

			
		if stars == 3:
			_1_star.show()
			_2_star.show()
			_3_star.show()
		elif stars == 2:
			_1_star.show()
			_2_star.show()
		elif stars == 1:
			_1_star.show()
			
		level_complete.show()
		
		
		#if SaveSystem.get_total_stars() < 6:
			#next_level_button.disabled = true
			#no_stars_label.show()
			#no_stars_label.text = "You only have " + str(SaveSystem.get_total_stars()) + "/6 stars to get into 2nd chapter!"



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/Scenes/Levels/level_4.tscn")