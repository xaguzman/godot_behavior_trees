extends "res://addons/xaguzman.behavior_trees/core/behavior-node.gd"

var _children : Array

func add_child_node(new_child)->void:
    _children.append(new_child)

func restart()->void:
    for child in _children:
        child.restart()
    pass
    
