extends Control


@onready var arrow: Sprite2D = %Arrow
@onready var level_1: TextureButton = %Level1
@onready var level_2: TextureButton = %Level2
@onready var level_3: TextureButton = %Level3
@onready var level_4: TextureButton = %Level4
@onready var level_5: TextureButton = %Level5



var levels_position: Array = []
var current_level : int = 1

 
func _ready() -> void:
	#SaveSystem.reset_stars()
	SaveSystem.load_data()


	levels_position = [
		level_1.position,
		level_2.position,
		level_3.position,
		level_4.position,
		level_5.position
	]
	
	
	update_option_position()


func change_lvl() -> void:
	if Input.is_action_just_pressed("select"):
		if current_level == 1:
			var last_lvl = SaveSystem.data.last_level
			get_tree().change_scene_to_file("res://assets/Scenes/Levels/cp1_lvl1.tscn")
		elif current_level == 2:
			get_tree().change_scene_to_file("res://assets/Scenes/Levels/cp1_lvl2.tscn")
	
		

func _process(delta: float) -> void:
	change_lvl()
	#print(current_option)
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("up"):
		move_character(-1)
	elif Input.is_action_just_pressed("right") or Input.is_action_just_pressed("down"):
		move_character(1)


func move_character(direction: int) -> void:
	current_level = clamp(current_level + direction, 1, levels_position.size())
	update_option_position()

func update_option_position() -> void:
	arrow.position = Vector2(levels_position[current_level - 1].x, levels_position[current_level - 1].y - 30)