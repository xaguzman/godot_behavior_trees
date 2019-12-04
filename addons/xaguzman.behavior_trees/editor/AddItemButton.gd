tool
extends MenuButton

signal popup_closed(created_node)

const Composite = preload("res://addons/xaguzman.behavior_trees/editor/node-editors/CompositeNode.tscn")
const Delay = preload("res://addons/xaguzman.behavior_trees/editor/node-editors/DelayDecorator.tscn")
const Action = preload("res://addons/xaguzman.behavior_trees/editor/node-editors/Action.tscn")

var was_cancelled : bool

var _sequence_id = 10
var _selector_id = 11
var _parallel_id = 12

var _action_id = 20

var _delay_id = 30

func _ready():
    var submenu = get_popup()
    submenu.clear()
    submenu.connect("id_pressed", self, "item_pressed")
    submenu.connect("popup_hide", self, "popup_hidden")
    submenu.add_separator("Composites")
    submenu.add_item("Sequence", 10)
    submenu.add_item("Selector", 11)
    submenu.add_item("Parallel", 12)
    
    submenu.add_separator("Leaves")
    submenu.add_item("Action", 20)
    
    submenu.add_separator("Decorators")
    submenu.add_item("Delay", 30)

func item_pressed(id: int)->void:
    was_cancelled = false
    var new_node : GraphNode
    match id:
        _sequence_id:
            new_node = Composite.instance()
            new_node.type = "Sequence"
        _selector_id:
            new_node = Composite.instance()
            new_node.type = "Selector"
        _parallel_id:
            new_node = Composite.instance()
            new_node.type = "Parallel"
        
        _action_id:
            new_node = Action.instance()
        
        _delay_id:
            new_node = Delay.instance()
            
    emit_signal("popup_closed", new_node)
    
    
func popup_at(pos: Vector2)->void:
    was_cancelled = true
    get_popup().popup( Rect2(pos, get_popup().get_minimum_size()))

func popup_hidden():
    if was_cancelled:
        emit_signal("popup_closed", null)
