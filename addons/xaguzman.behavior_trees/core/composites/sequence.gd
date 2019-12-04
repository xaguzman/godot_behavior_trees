"""
Keeps executing its children while they return Success. Once one returns Failure or Running, it stops.
If Running is returned, on next iteration  it will start from the child that returned Running
"""
extends "res://addons/xaguzman.behavior_trees/core/composites/composite-node.gd"

var _last_running_index : int = 0

func tick(delta: float)->int:
    var current_index = _last_running_index
    while (current_index < _children.size()):
        var child_result = _children[current_index].tick(delta)
        
        if child_result == BehaviorTreeGlobals.FAILURE:
            status = BehaviorTreeGlobals.FAILURE
            break
        
        if child_result == BehaviorTreeGlobals.RUNNING:
            _last_running_index = current_index
            status = BehaviorTreeGlobals.RUNNING
            break
        
        current_index += 1
    
    restart()
    status = BehaviorTreeGlobals.SUCCESS
    return status

func restart():
    .restart()
    _last_running_index = 0
