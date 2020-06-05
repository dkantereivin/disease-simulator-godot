extends Button

const StatsEngine = preload('res://Scripts/StatsEngine.gd')

func _pressed():
	get_tree().paused = true
	export_data()
	
func export_data():
	var config = $'../PlayPause_Button'.get_config()
	var stats = $'../../SimArea'.statistics
	var save_data = File.new()
	var file_name = "user://sim-data-{day}_{month}_{year}-{hour}.{minute}.{second}.csv".format(OS.get_datetime())
	save_data.open(file_name, File.WRITE)
	save_data.store_line('Elapsed Time,Negative,Positive,Immune,Deceased,Total Cases')
	for i in range(stats.size()):
		save_data.store_line(generate_line(i, stats[i]))
	save_data.store_line('R-Naught,Population,Infect Chance,Distancing %,Infection Duration,Immunity Duration,Mortality %')
	save_data.store_line(
			StatsEngine.r_naught($'../../SimArea'.population, total_cases(stats.back())) as String+ 
			',{population},{infect_chance},{distancing},{infection_dur},{immunity_dur},{mortality}'.format(config)
		)
	save_data.close()

func generate_line(s: int, data: Array) -> String:
	var dict_data = {
		'time': s * 2,
		'neg': data[0],
		'pos': data[1],
		'immune': data[2],
		'deceased': data[3],
		'cases': total_cases(data)
		}
	return '{time},{neg},{pos},{immune},{deceased},{cases}'.format(dict_data)
	
func total_cases(data: Array) -> int:
	return data[1] + data[2] + data[3]
