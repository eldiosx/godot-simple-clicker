extends Control

@onready var ResOptionButton = $Options/ResolutionContainer/OptionButton
@onready var FullscreenToggle = $Options/FullscreenContainer/FullScreenToggle
@onready var VsyncToggle = $Options/VsyncContainer/VSYNCHECK
@onready var FXAAToggle = $Options/FXAAContainer/FXAACheck
@onready var MSAASlider = $Options/MSAA/MSAASlider

var Resolutions: Dictionary = {"3840x2160":Vector2(3840,2160),
								"2560x1440":Vector2(2560,1440),
								"1920x1080":Vector2(1920,1080),
								"1366x768":Vector2(1366,768),
								"1536x864":Vector2(1536,864),
								"1280x720":Vector2(1280,720),
								"1440x900":Vector2(1440,900),
								"1600x900":Vector2(1600,900),
								"1024x600":Vector2(1024,600),
								"800x600": Vector2(800,600)}

func _ready():
	AddResolutions()
	FullscreenToggle.button_pressed = ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))
	VsyncToggle.set_pressed_no_signal((DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED))
	FXAAToggle.set_pressed_no_signal(get_viewport().get_use_fxaa())
	MSAASlider.set_value(get_viewport().get_msaa())

func AddResolutions():
	var CurrentResolution = get_viewport().get_size()
	
	var Index = 0 
	
	for r in Resolutions:
		ResOptionButton.add_item(r,Index)
		
		if Resolutions[r] == CurrentResolution:
			ResOptionButton._select_int(Index)
		Index += 1

func _on_OptionButton_item_selected(index):
	var size = Resolutions.get(ResOptionButton.get_item_text(index))
	get_window().set_size(size)
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,size)

func _on_FullScreenToggle_toggled(button_pressed):
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (button_pressed) else Window.MODE_WINDOWED
	
	if button_pressed == false:
		var size = get_viewport().get_size()
		get_window().set_size(size)
		OS.center_window()

func _on_FXAACheck_toggled(button_pressed):
	get_viewport().set_use_fxaa(button_pressed)
	if button_pressed:
		get_viewport().set_sharpen_intensity(.5)
	else:
		get_viewport().set_sharpen_intensity(0)
func _on_MSAASlider_value_changed(value):
	get_viewport().set_msaa(value)
	
func _on_VSYNCHECK_toggled(button_pressed):
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (button_pressed) else DisplayServer.VSYNC_DISABLED)


func _on_Button_pressed():
	assert(get_tree().change_scene_to_file("res://scenes/menu.tscn") == OK)
	pass
