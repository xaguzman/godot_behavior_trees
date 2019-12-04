extends "res://addons/xaguzman.behavior_trees/core/decorators/behavior-node-decorator.gd"

func tick(delta: float)->int:
    var res = target.tick(delta)
    if res == BehaviorTreeGlobals.SUCCESS:
        status = BehaviorTreeGlobals.FAILURE
    elif res == BehaviorTreeGlobals.FAILURE:
        status = BehaviorTreeGlobals.SUCCESS
    else:
        status = BehaviorTreeGlobals.RUNNING
    
    return status

#func restart():
#    target.restart()
