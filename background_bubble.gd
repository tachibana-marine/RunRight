class_name BackgroundBubble
extends Node2D

@export var color: Color = "ccd4e4"

var num_bubbles = 0
var sprite_texture = load("res://asset/1px.png")
var length = 0

const TWEEN_DURATION = 10
const INIT_SCALE = Vector2(60, 60)
const MAX_TAILS = 5
const BUBBLE_DISTANCE = 60

func _ready() -> void:
    num_bubbles = randi() % MAX_TAILS + 2
    var previous_position = Vector2.ZERO
    var previous_scale = Vector2.ZERO
    for i in range(num_bubbles):
        var tail = Sprite2D.new()
        tail.texture = sprite_texture
        tail.modulate = color
        tail.scale = INIT_SCALE * pow(0.8, i)
        tail.position = position
        if (i > 0):
            tail.position.x = previous_position.x \
            + previous_scale.x / 2 + BUBBLE_DISTANCE + tail.scale.x / 2
        length += tail.scale.x + BUBBLE_DISTANCE
        previous_position = tail.position
        previous_scale = tail.scale
        $SpriteNode.add_child(tail)
        var tween = create_tween()
        tween.tween_property(self, "position:x", 
        -(length + get_viewport().size.x), 1)
        tween.tween_callback(self.queue_free)
