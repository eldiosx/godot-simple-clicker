extends Control

var coins = 0
var worker_units = 0
var computer_units = 0
var ram_units = 1
var worker_cost = 50
var computer_cost = 100
var ram_cost = 500

func _on_Work_pressed():
	coins += 1
	pass

func _on_Worker_pressed():
	if coins >= worker_cost:
		coins -= worker_cost
		worker_units += 1
		worker_cost += 10
		if worker_units >= 100:
			$Server/Worker.hide()
			$Cost/WorkerCost.hide()
			worker_units = 100
		else:
			pass
	else:
		$Text.text = "No money"
		await get_tree().create_timer(1.0).timeout
		$Text.text = ""
	pass
	
func _on_Computer_pressed():
	if coins >= computer_cost:
		coins -= computer_cost
		computer_cost += 50
		computer_units += 1
		if computer_units >= 50:
			$Server/Computer.hide()
			$Cost/ComputerCost.hide()
			computer_units = 50
		else:
			pass
	else:
		$Text.text = "No money"
		await get_tree().create_timer(1.0).timeout
		$Text.text = ""
	pass

func _on_Ram_pressed():
	if coins >= ram_cost:
		coins -= ram_cost
		ram_cost *= 2
		ram_units += 1
		if ram_units >= 5:
			$Server/Ram.hide()
			$Cost/RamCost.hide()
			ram_units = 5
		else:
			pass
	else:
		$Text.text = "No money"
		await get_tree().create_timer(1.0).timeout
		$Text.text = ""
	pass

func _on_HACK_pressed():
	coins += 500
	pass

func _process(_delta):
	$Coins.text = "Coins: "+str(coins)
	$WorkerUnits.text = "Workers: "+str(worker_units)
	$ComputerUnits.text = "Computers: "+str(computer_units)
	$RamUnits.text = "Ram DDR: "+str(ram_units)
	$Cost/WorkerCost.text = "Cost: "+str(worker_cost)
	$Cost/ComputerCost.text = "Cost: "+str(computer_cost)
	$Cost/RamCost.text = "Cost: "+str(ram_cost)
	coins += 0.01 * worker_units
	coins += 0.05 * computer_units * ram_units
	pass

func _on_Menu_pressed():
	assert(get_tree().change_scene_to_file("res://scenes/menu.tscn") == OK)
	pass
