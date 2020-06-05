enum HealthStates {
	NEGATIVE,
	POSITIVE,
	IMMUNE,
	DECEASED
}

static func health_states(population: Array) -> Array:
	var state = [0, 0, 0, 0]
	for indiv in population:
		state[indiv.state] += 1
	return state
	
static func r_naught(population: Array, infected: int) -> float:
	var sum = 0
	for indiv in population:
		sum += indiv.victims
	return sum / float(infected)