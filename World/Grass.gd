extends Node2D

#	Gain access to the GrassEffect scene
const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func create_grass_effect():
#	Create an instance of that grass effect for the grass node
	var grassEffect = GrassEffect.instance()
#	get access to the world scene
#	var world = get_tree().current_scene //Removing but wanted to keep here for reference on how to get world scene
#	Add a child node to parent node
	get_parent().add_child(grassEffect)
#	Set the position of the grass effect instance to the global position of the grass that this script belongs to
	grassEffect.global_position = global_position

#	event / signal trigger function for when the hurtbox area is entered
func _on_HurtBox_area_entered(area):
#	trigger the grass effect method above
	create_grass_effect()
#	remove the node from the scene
	queue_free()
