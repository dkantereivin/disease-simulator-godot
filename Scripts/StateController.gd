extends TextureButton

var sim
var has_started = false

func _ready():
	sim = get_node('/root/Container/SimArea')

func get_config() -> Dictionary:
	return {
		'population': int($'../Population_Input'.get_text()),
		'infect_chance': float($'../Infect_Chance_Input'.get_text()),
		'distancing': float($'../Distancing_Pop_Input'.get_text()),
		'infection_dur': float($'../Infection_Dur_Input'.get_text()),
		'immunity_dur': float($'../Immunity_Dur_Input'.get_text()),
		'mortality': float($'../Mortality_Input'.get_text())
	}
	
func start_game():
    sim.start_simulation(get_config())

func play():
    if not has_started:
        start_game()
        has_started = true
    get_tree().paused = false
    allow_inputs(false)

func pause():
    get_tree().paused = true
    
func reset():
	sim.reset()
	self.pressed = false
	pause()
	allow_inputs(true)
	has_started = false

func _pressed():
	if $".".pressed:
	    play()
	else:
	    pause()

func allow_inputs(is_enabled: bool) -> void:
	$'../Population_Input'.editable = is_enabled
	$'../Infect_Chance_Input'.editable = is_enabled
	$'../Distancing_Pop_Input'.editable = is_enabled
	$'../Infection_Dur_Input'.editable = is_enabled
	$'../Immunity_Dur_Input'.editable = is_enabled
	$'../Mortality_Input'.editable = is_enabled