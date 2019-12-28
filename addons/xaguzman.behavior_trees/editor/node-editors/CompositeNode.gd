tool
extends GraphNode

signal deleted_node(index)

#const IN_COLOR = Color("0172b5")
#const OUT_COLOR = Color("da39e3")
const COMPOSITE_CHILD = preload("res://addons/xaguzman.behavior_trees/editor/node-editors/CompositeNodeChild.tscn")

export (String, "Sequence", "Selector", "Parallel") var type setget set_composite_type

func set_composite_type(val: String)-> void:
    type = val
    title = val

func _ready():
    set_meta("composite_node_tag", "")
    _update_slots()

func _update_slots():
    for i in range(1, get_child_count(), 1):
        set_slot(i, false, 0, BTEditorGlobals.DEFAULT_NODE_COLOR, true, 0, BTEditorGlobals.DEFAULT_NODE_COLOR)
        
func _on_AddNew_pressed():
    var new_child = COMPOSITE_CHILD.instance()
    add_child(new_child)
    new_child.connect("removed", self, "_on_ChildNode_removed")
    new_child.owner = owner
    var idx = get_child_count() - 1
    new_child.index = idx - 1
    set_slot(idx, false, 0, BTEditorGlobals.DEFAULT_NODE_COLOR, true, 0, BTEditorGlobals.DEFAULT_NODE_COLOR)

   
func _on_ChildNode_removed(index):
    var list_index = index + 1
    var removed_item = get_child(list_index)
    removed_item.queue_free()
    emit_signal("deleted_node", index)
    for i in range(list_index, get_child_count(), 1):
        get_child(i).index -= 1    
