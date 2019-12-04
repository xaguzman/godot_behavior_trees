"""
Base class for all behavior nodes to implement
"""

extends Node
export (String) var caption

# one of BehaviorTree.SUCCESS, BehaviorTree.FAILURE, BehaviorTree.RUNNING
var status : int

# returns one of BehaviorTree.SUCCESS, BehaviorTree.FAILURE, BehaviorTree.RUNNING
func tick(delta: float)->int:
    return status

func restart()->void:
    pass
