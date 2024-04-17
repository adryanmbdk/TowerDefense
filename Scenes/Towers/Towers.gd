extends Node2D

var enemies = []
var built = false
var enemy

func _ready():
	if built:
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[self.get_name()]["range"]

func _physics_process(delta):
	if enemies.size() != 0 and built:
		select_enemy()
		turn()
	else:
		enemy = null
	
func select_enemy():
	var enemies_progress = []
	for i in enemies:
		enemies_progress.append(i.progress) ## Progress is how may pixels enemy has travelled
	var max_offset = enemies_progress.max()
	var enemy_index = enemies_progress.find(max_offset)
	enemy = enemies[enemy_index]

func turn():
	get_node("Tower").look_at(enemy.position)

func _on_range_body_entered(body):
	enemies.append(body.get_parent())

func _on_range_body_exited(body):
	enemies.erase(body.get_parent())
