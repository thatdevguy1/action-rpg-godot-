extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = CHASE

# when the nodes are ready grab the Stats scene and save it to the stats variable
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $AnimatedSprite

func _physics_process(delta):
#	setting the knock back direction and speed
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()		
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
#				Git the difference between position of the player and bat, normalized so that we get the general direction
				var direction = (player.global_position - global_position).normalized()
#				move in the direction at the MAX_SPEED
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_HurtBox_area_entered(area):
#	area is the hitbox entering the hurtbox. damage is the value we set on the specific hitbox being used
	stats.health -= area.damage
	knockback = area.knockback_vector * 120

# no health signal being emitted from stats will trigger this method 
func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
