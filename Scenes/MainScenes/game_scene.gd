extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type

func _ready():
	map_node = get_node("Map1") ##turn this into variable based on selected map
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))

func _process(_delta):
	if build_mode:
		update_tower_preview()
	
func _unhandled_input(event):
	if event.is_action_released("cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("confirm") and build_mode == true:
		verify_and_build()
	
func initiate_build_mode(tower_type):
	build_type = tower_type + "T1"
	build_mode = true 
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_local(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cell_source_id(0, current_tile): #ARRUMAR UM JEITO DE NAO PERMITIR COLOCAR UM EM CIMA DO OUTRO
		get_node("UI").update_tower_preview(tile_position, "00d115d1")
		build_valid = true 
		build_location = tile_position
	else:
		get_node("UI").update_tower_preview(tile_position, "d10000d1") 
		build_valid = false
		
func cancel_build_mode():
	build_mode = false 
	build_valid = false 
	get_node("UI/TowerPreview").queue_free()
	
func verify_and_build():
	if build_valid:
		var new_tower = load("res://Scenes/Towers/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		map_node.get_node("Towers").add_child(new_tower, true)
