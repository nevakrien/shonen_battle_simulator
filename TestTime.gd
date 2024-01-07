extends Node

# Importing the Time script as a preload. Make sure the path is correct.
var time = preload("res://Time.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	#error on empty list
	assert(time.get_cur_event()==null)

	#adding valud events should work
	assert(!time.add_event(time.Event(0.7)))
	assert(!time.add_event(time.Event(0.5)))
	
	#steping should give the 0.5 event
	time.next_step()
	var first_time=time.get_time()
	var first_event=time.get_cur_event()
	
	#stuff should work when called multiple times
	assert(time.get_time()==0.5)
	assert(time.get_cur_event()==first_event)
	assert(time.get_time()==first_time)
	
	#on colition first in first out
	var hold_event = time.Event(0.7)
	assert(!time.add_event(hold_event))
	
	time.next_step()
	assert(time.get_time()==0.7)
	assert(hold_event!=time.get_cur_event())
	
	time.next_step()
	assert(time.get_time()==0.7)
	assert(hold_event==time.get_cur_event())
	
	#empty list should return null
	time.next_step()
	assert(time.get_time()==0.7)
	assert(time.get_cur_event()==null)
	
	#invalid entring should not work
	assert(time.add_event(time.Event(0.5)))
	time.next_step()
	assert(time.get_time()==0.7)
	assert(time.get_cur_event()==null)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# This function is currently empty, meaning it doesn't perform any specific actions every frame.
	pass
