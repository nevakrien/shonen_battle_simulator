extends Node

var time =0.0
var events = []
var entity_events={}
#class_name ShonenEvent
class ShonenEntity: 
	pass
class ShonenEvent:
	var time : float
	var command 
	var entity 
	
func next_events():
	var ans = []
	for event in events:
		if event.time<time:
			continue
		if len(ans) == 0:
			ans.append(event)
			continue
		if event.time==ans[0].time:
			ans.append(event)
			continue 
		if event.time<ans[0].time:
			ans=[event]
	return ans 

func get_entity_event_list(entity):
	if entity_events.has(entity):
		return entity_events[entity]
	var ans=[]
	entity_events[entity]=ans 
	return ans
	
func add_event(event : ShonenEvent):
	events.append(event)
	get_entity_event_list(event.entity).append(event)
		
func is_priorety(entity):
	var my_events = entity_events.get(entity,[])
	for event in my_events.reversed(): 
		#if event.entity!=entity:
		#	continue
		if event.time>time:
			return false
	return true;
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
