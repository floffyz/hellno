extends Area2D

var animation_speed = 2
var moving = false
var tile_size = 64
@onready var tile_map: TileMap = %TileMap

var inputs = {
	"left": Vector2.RIGHT,
	"right": Vector2.LEFT,
	"down": Vector2.UP,
	"up": Vector2.DOWN
}
var last_move
var last_pos
var tile
var tile_pos

@onready var ray = $RayCast2d

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2
	
func _unhandled_input(event):
	if moving or GameManager.blocked:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			#await get_tree().create_timer(0.5).timeout
			move(dir)
			
func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if GameManager.checker(dir, ray, inputs, tile_size) == true:
		tile_pos = tile_map.local_to_map(transform.get_origin()) 
		
		last_pos = position
		#prints(last_pos, tile_pos)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false

		
		

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Kids") || area.is_in_group("Player"):
		var tween = get_tree().create_tween()
		moving = true
		tween.tween_property(self, "position", tile_map.map_to_local(tile_pos), 1.0/animation_speed).set_trans(Tween.TRANS_SINE)

		
		await tween.finished
		moving = false
		
	if area.is_in_group("Exit"):
		self.queue_free()
		get_parent().saved += 1