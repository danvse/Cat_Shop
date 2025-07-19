extends WorldEnvironment


func _ready():
	var new_env = Environment.new()
	new_env.background_mode = Environment.BG_SKY
	
	var sky = PanoramaSkyMaterial.new()
	sky.panorama = load("res://Clouds/Clouds_1/1.png")
	
	new_env.sky = sky

	environment = new_env
