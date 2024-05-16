extends Node2D

@export var min_size = Vector2(0,0)

var mouse_position = get_global_mouse_position()
var relative_mouse_motion = Vector2(0,0)

@onready var nine_patch = $NinePatchRect

enum { 
	RESIZE_NONE, 
	RESIZE_RIGHT, RESIZE_LEFT, RESIZE_BOTTOM, RESIZE_TOP,
	RESIZE_TL, RESIZE_TR, RESIZE_BL, RESIZE_BR 
}
var resize = RESIZE_NONE

var move = false

func _ready():
	%HeaderBar.custom_minimum_size = Vector2(0, 16)

func _process(delta):
	match resize:
		RESIZE_RIGHT:
			nine_patch.size.x += relative_mouse_motion.x
		RESIZE_LEFT:
			nine_patch.size.x -= relative_mouse_motion.x
			nine_patch.position.x += relative_mouse_motion.x
		RESIZE_BOTTOM:
			nine_patch.size.y += relative_mouse_motion.y
		RESIZE_TOP:
			nine_patch.size.y -= relative_mouse_motion.y
			nine_patch.position.y += relative_mouse_motion.y
		RESIZE_BL:
			nine_patch.size += Vector2(-relative_mouse_motion.x, relative_mouse_motion.y)
			nine_patch.position.x += relative_mouse_motion.x
		RESIZE_BR:
			nine_patch.size += relative_mouse_motion
		RESIZE_TL:
			nine_patch.size -= relative_mouse_motion
			nine_patch.position += relative_mouse_motion
		RESIZE_TR:
			nine_patch.size += Vector2(relative_mouse_motion.x, -relative_mouse_motion.y)
			nine_patch.position.y += relative_mouse_motion.y
	
	if move:
		position += relative_mouse_motion
	
	relative_mouse_motion = Vector2(0,0)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			resize = RESIZE_NONE
	elif event is InputEventMouseMotion:
		var current_mouse_position = event.global_position
		relative_mouse_motion += current_mouse_position - mouse_position
		mouse_position = current_mouse_position
		
func _on_resize_right_button_down():
	resize = RESIZE_RIGHT
func _on_resize_left_button_down():
	resize = RESIZE_LEFT
func _on_resize_bottom_button_down():
	resize = RESIZE_BOTTOM
func _on_resize_top_button_down():
	resize = RESIZE_TOP
func _on_resize_bl_button_down():
	resize = RESIZE_BL
func _on_resize_br_button_down():
	resize = RESIZE_BR
func _on_resize_tr_button_down():
	resize = RESIZE_TR
func _on_resize_tl_button_down():
	resize = RESIZE_TL


func _on_header_bar_button_down():
	move = true
func _on_header_bar_button_up():
	move = false


func _on_close_button_pressed():
	visible = false
