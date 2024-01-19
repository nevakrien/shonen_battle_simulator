extends GutTest

var time
# Importing the Time script as a preload. Make sure the path is correct.
func before_each():
	time = preload("res://Time.gd")

# Called when the node enters the scene tree for the first time.
func test_time():
	#to check the testing framework works
	#assert_true(time.get_cur_event()!=null)
	#return
	
	#error on empty list
	assert_true(time.get_cur_event()==null)

	#adding valud events should work
	assert_true(!time.add_event(time.ShonenEvent.new(0.7)))
	assert_true(!time.add_event(time.ShonenEvent.new(0.5)))
	
	#steping should give the 0.5 event
	time.next_step()
	var first_time=time.get_time()
	var first_event=time.get_cur_event()
	
	#stuff should work when called multiple times
	assert_true(time.get_time()==0.5)
	assert_true(time.get_cur_event()==first_event)
	assert_true(time.get_time()==first_time)
	
	#on colition first in first out
	var hold_event = time.ShonenEvent.new(0.7)
	assert_true(!time.add_event(hold_event))
	
	time.next_step()
	assert_true(time.get_time()==0.7)
	assert_true(hold_event!=time.get_cur_event())
	
	time.next_step()
	assert_true(time.get_time()==0.7)
	assert_true(hold_event==time.get_cur_event())
	
	#empty list should return null
	time.next_step()
	assert_true(time.get_time()==0.7)
	assert_true(time.get_cur_event()==null)
	
	#invalid entring should not work
	assert_not_null(time.add_event(time.ShonenEvent.new(0.5)))
	time.next_step()
	assert_true(time.get_time()==0.7)
	assert_true(time.get_cur_event()==null)
