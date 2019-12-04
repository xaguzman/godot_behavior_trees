extends "res://addons/xaguzman.behavior_trees/core/decorators/behavior-node-decorator.gd"

export (float) var time setget set_time

var _time_left: float

func _ready():
    pass

func set_time(val: float)->void:
    time = val
    _time_left = val

func tick(delta: float)->int:
    _time_left -= delta
    status = BehaviorTreeGlobals.RUNNING if _time_left > 0 else target.tick(delta)
    return status

func restart():
    _time_left = time
