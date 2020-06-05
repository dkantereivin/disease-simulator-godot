extends Node2D

const Individual = preload('res://Individual.tscn')
const StatsEngine = preload('res://Scripts/StatsEngine.gd')

var population = []
var statistics = []

func _ready():
	print($Sim_Timer.connect("timeout", self, "_on_timeout"))	

func start_simulation(config: Dictionary):
	# Individuals who follow social distancing are immobile, the remainder are transporters.
	# TODO: Documentation & Page Number.
	var immobile = int(round(config['population'] * config['distancing'] / 100))
	
	for i in range(config['population']):
		var new_node = Individual.instance()
		add_child(new_node)
		new_node.set_position(rand_pos())
		new_node.sim_config = config

		if i > immobile:
			new_node.is_mobile = true
			new_node.linear_velocity = rand_linear_velocity()
		else:
			new_node.mode = RigidBody2D.MODE_STATIC
		population.append(new_node)
	
	population.back().infect()
	$Sim_Timer.start()
	
	
func _on_timeout():
	var turn = StatsEngine.health_states(population)
	statistics.append(turn)
	print(turn)
	if turn[1] < 1:
		get_tree().paused = true

func reset() -> void:
	for indiv in population:
		indiv.queue_free()
	population.clear()

# Returns random (x, y) coordinates within the SimArea bounds.
func rand_pos() -> Vector2:
	return Vector2(
		rand_range(15, 820),
		rand_range(50, 580)
	)

func rand_linear_velocity() -> Vector2:
	return Vector2(
		rand_range(-100, 100),
		rand_range(-100, 100)
	)
	
func total_infected() -> int:
	return statistics[-1][1] + statistics[-1][2] + statistics[-1][3]
