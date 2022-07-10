extends AnimatedSprite

func _ready():
#	connect to our own objects signal called animation_finished, call the _on_animation_finished function from our self (this object)
	connect("animation_finished", self, "_on_animation_finished")
#	sets the frames to 0 for the animation that we have set up
	frame = 0
#	plays the Animate animation that we set in the frames on the inspector dashboard
	play("Animate")


func _on_animation_finished():
	queue_free();
