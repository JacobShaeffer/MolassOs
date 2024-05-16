class_name Parent
extends Node2D

signal mouse_entered
signal mouse_exited

var has_child = false
var child_carrier = null
var child_card = null

func add_card(node):
	child_card = node
	child_carrier.add_child(node)
	has_child = true
	
func remove_card(node):
	child_carrier.remove_child(node)
	child_card = null
	has_child = false
	
func _on_area_2d_mouse_entered():
	emit_signal("mouse_entered", self)
	
func _on_area_2d_mouse_exited():
	emit_signal("mouse_exited", self)
