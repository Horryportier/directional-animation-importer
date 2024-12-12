@tool
class_name SpriteFrameComposer
extends Resource

enum AnimationDirection {
	S,
	SE,
	SW,
	N,
	NE,
	NW,
	W,
	E,
}
const S: = AnimationDirection.S
const SE: = AnimationDirection.SE
const SW: = AnimationDirection.SW
const N: = AnimationDirection.N
const NE: = AnimationDirection.NE
const NW: = AnimationDirection.NW
const W: = AnimationDirection.W
const E: = AnimationDirection.E

var default_direction_order: Array[AnimationDirection] = [S, SW, W, NW, N, NE, E, SE] 


@export_group("input")
## use tihs to set sprite sheet for compositor
@export var texture: Texture2D
## name will be used as prefix for animations
@export var name: String
## size of individual frame *compositiors dont need to have the same frame_size*
@export var frame_size: Vector2
## how many frames is in one animation (expects every direction has the same amount of frames)
@export var frames_per_animation: int
## sets looping for animation  (dose not work for now)
@export var animation_loop: bool 
## sets animation spedd for animation
@export var animation_speed: float = 5
## order in which sprites are set in the sprite_sheet
@export var direction_order: Array[AnimationDirection] = [S, SW, W, NW, N, NE, E, SE] 
@export_group("output")
## sprite_frame generated is generated after generete button is cliked in AnimationComposer
@export var sprite_frames: SpriteFrames
## saves file to specified path if no path specified then dose nothing 
@export var save_file: String


func generate_sprite_frames() -> SpriteFrames:
	var sf = SpriteFrames.new()
	for idx in  len(direction_order):
		var anim_name: = "%s_%s" % [name, AnimationDirection.keys()[direction_order[idx]]]
		sf.add_animation(anim_name)
		sf.set_animation_loop(anim_name, animation_loop)
		sf.set_animation_speed(anim_name, animation_speed)
		for i in frames_per_animation:
			var frame: = AtlasTexture.new()
			frame.atlas = texture
			frame.region =  Rect2(Vector2(i * frame_size.x, idx * frame_size.y),frame_size)
			sf.add_frame(anim_name, frame)
	return sf




