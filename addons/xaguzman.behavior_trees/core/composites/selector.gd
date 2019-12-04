"""
Executes the given list of BehaviorNode in order from 0 to N. Once one of them returns BehaviorResult.Success or BehaviorResult.Running
it stops checking its child nodes. Make sure that the lower index nodes have heavier requirements to be fullfilled, so the next nodes have a good chance of
being executed.
"""
extends "res://addons/xaguzman.behavior_trees/core/composites/composite-node.gd"


var _last_running_index : int = 0

func tick(delta: float)->int:
    var result = BehaviorTreeGlobals.FAILURE
    var current_index = 0
    while (current_index < _children.size() && result == BehaviorTreeGlobals.FAILURE):
        result = _children[current_index].tick(delta)
        current_index+=1
        
    if _last_running_index > current_index:
        _children[_last_running_index].restart()
    
    _last_running_index = int(min(_children.size() - 1, current_index))
    for i in range(current_index-2, -1, -1):
        _children[i].restart()
    
    status = result
    return status

func restart():
    .restart()
    _last_running_index = 0
