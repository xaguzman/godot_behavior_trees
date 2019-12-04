extends "res://addons/xaguzman.behavior_trees/core/decorators/behavior-node-decorator.gd"

func _ready():
    pass

func tick(delta: float)-> int:
    var res = BehaviorTreeGlobals.SUCCESS
    while (res != BehaviorTreeGlobals.FAILURE):
        res = target.tick(delta)
    
    status = BehaviorTreeGlobals.SUCCESS
    return status
