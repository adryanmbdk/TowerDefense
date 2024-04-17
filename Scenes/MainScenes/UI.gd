extends CanvasLayer

var fastForward = false

func set_tower_preview(tower_type, mouse_position):
	if get_node("TowerPreview"):
		get_node("TowerPreview").queue_free()
		remove_child(get_node("TowerPreview"))
	
	var drag_tower = load("res://Scenes/Towers/" + tower_type + ".tscn").instantiate()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("6bff5492")
	
	var range_texture = Sprite2D.new()
	range_texture.position = Vector2(0,0)
	var scaling = GameData.tower_data[tower_type]["range"] / 600.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://Assets/Towers/range_overlay.png")
	range_texture.texture = texture
	range_texture.modulate = Color("00d115d1")
	
	var control = Control.new()
	control.add_child(drag_tower,true)
	control.add_child(range_texture,true)
	control.set_position(mouse_position)
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0)

func update_tower_preview(new_position, color):
	get_node("TowerPreview").set_position(new_position)
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/Sprite2D").modulate = Color(color)
		
##
## Game Control Functions
##
func _on_pause_play_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	if Engine.get_time_scale() == 0.0 and fastForward == true:
		Engine.set_time_scale(2.0)
	elif Engine.get_time_scale() == 0.0 and fastForward == false:
		Engine.set_time_scale(1.0)
	elif Engine.get_time_scale() >= 1.0:
		Engine.set_time_scale(0.0)
	
func _on_fast_forward_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	if Engine.get_time_scale() == 2.0 and fastForward == false:
		Engine.set_time_scale(1.0)
	elif Engine.get_time_scale() != 2.0 and fastForward == true:
		Engine.set_time_scale(2.0)
		
func _on_fast_forward_toggled(toggled_on):
	if toggled_on:
		fastForward = true
	else:
		fastForward = false
