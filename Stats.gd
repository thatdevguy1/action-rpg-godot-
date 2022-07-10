extends Node

export var max_health = 1
onready var health = max_health setget set_health

#Signal set up to trigger events
signal no_health

#setter function thats triggered when the health var gets set
func set_health(value):
	health = value
	if health <= 0:
#		emit an event (signal) when health is 0 triggering the no_health event (singal)
		emit_signal("no_health")
