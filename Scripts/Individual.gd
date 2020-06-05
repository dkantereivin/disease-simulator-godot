extends RigidBody2D
class_name Individual

const NEGATIVE_TEXTURE = preload('res://Textures/Healthy_Individual.png')
const POSITIVE_TEXTURE = preload('res://Textures/Infected_Individual.png')
const IMMUNE_TEXTURE = preload('res://Textures/Immune_Individual.png')
const DECEASED_TEXTURE = preload('res://Textures/Deceased_Individual.png')

enum HealthStates {
	NEGATIVE,
	POSITIVE,
	IMMUNE,
	DECEASED
}

var is_mobile = false
var victims: int = 0 # hehe
var state = HealthStates.NEGATIVE
var sim_config: Dictionary
onready var timer: Timer = Timer.new()
onready var sprite = $'Individual_Collide/Individual_Sprite'

func _ready():
	timer.connect('timeout', self, '_on_timeout')
	timer.one_shot = true
	add_child(timer)

func update_health(new_state) -> void:
	state = new_state
	
func infect():
	if timer.time_left > 0.0:
		return
	update_health(HealthStates.POSITIVE)
	sprite.set_texture(POSITIVE_TEXTURE)
	timer.start(sim_config['infection_dur'])
	
func develop_immunity():
	update_health(HealthStates.IMMUNE)
	sprite.set_texture(IMMUNE_TEXTURE)
	timer.start(sim_config['immunity_dur'])
	
func lose_immunity():
	update_health(HealthStates.NEGATIVE)
	sprite.set_texture(NEGATIVE_TEXTURE)
	
func death():
	update_health(HealthStates.DECEASED)
	sprite.set_texture(DECEASED_TEXTURE)
	self.mode = RigidBody2D.MODE_STATIC
	
func _on_timeout():
	if state == HealthStates.POSITIVE:
		if randf() <= sim_config['mortality'] / 100.0:
			death()
		else:
			develop_immunity()
	elif state == HealthStates.IMMUNE:
		lose_immunity()

func _process(delta):
	var colliding_bodies = get_colliding_bodies()
	for collision_indiv in colliding_bodies:
		if state == HealthStates.POSITIVE and collision_indiv.get('state') == HealthStates.NEGATIVE:
			if randf() <= sim_config['infect_chance'] / 100.0:
				collision_indiv.infect()
				victims += 1
	var velocity = get_linear_velocity().abs().x + get_linear_velocity().abs().y
	if (velocity < 20 or velocity > 220) and is_mobile:
		set_linear_velocity(rand_linear_velocity())
		
		
func rand_linear_velocity() -> Vector2:
	return Vector2(
		rand_range(-100, 100),
		rand_range(-100, 100)
	)
