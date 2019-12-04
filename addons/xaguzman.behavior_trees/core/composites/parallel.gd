"""
Executes all of its children everytime. If the minimum ammount of successes are returned by the children, this one will return
Success. If the minimum ammount of Failures are returned by the children, this will return Failures. Otherwise it will
return Running.

Priority is put on success rather than failures (meaning that if both, requiredSuccess and requiredFailures are met, it will
still return Success)
"""
extends "res://addons/xaguzman.behavior_trees/core/composites/composite-node.gd"

export (int) var required_successes = -1
export (int) var required_failures = -1

func tick(delta: float)->int:
    
    if required_failures == -1:
        required_failures = _children.size()
    if required_successes == -1:
        required_successes = _children.size()
    
    var count_success = 0
    var count_failures = 0
    
    for child in _children:
        var child_result = child.tick(delta)
        if child_result == BehaviorTreeGlobals.SUCCESS:
            count_success += 1
        elif child_result == BehaviorTreeGlobals.FAILURE:
            count_failures += 1
        
    if count_success >= required_successes:
        status = BehaviorTreeGlobals.SUCCESS
    elif count_failures >= required_failures:
        status = BehaviorTreeGlobals.FAILURE
    else:
        status = BehaviorTreeGlobals.RUNNING
    
    return status
