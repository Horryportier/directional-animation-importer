@tool
class_name  AnimationComposer
extends Node

## when pressed will generete `sprite_frames` from every SpriteFrameComposer
@export var generate: bool: 
	set(val):
		if val:
			generate = val	
			for composer in composers:
				composer.sprite_frames =  composer.generate_sprite_frames()
				if composer.save_file != "":
					ResourceSaver.save(composer.sprite_frames, composer.save_file)
			sprite_frames = _merge_sprite_frames()
			if save_file != "":
				ResourceSaver.save(sprite_frames, save_file)
			generate = false

@export_group("input")
## list of SpriteFrameComposer's this where you put all your animations as seprate composers
@export var composers: Array[SpriteFrameComposer]


@export_group("output")
## sprite_frame will be automaticly set after clicking generate button
@export var  sprite_frames: SpriteFrames
## save file path for sprite_frames
@export var  save_file: String

## marges all animations into one dose not support animation with the same name 
func _merge_sprite_frames() -> SpriteFrames:
	var sf: = SpriteFrames.new()
	for composer in composers:
		var csf: SpriteFrames = composer.sprite_frames
		for name in  csf.get_animation_names():
			sf.add_animation(name)
			sf.set_animation_speed(name, csf.get_animation_speed(name))
			sf.set_animation_loop(name, csf.get_animation_loop(name))
			for i in csf.get_frame_count(name):
				sf.add_frame(name, csf.get_frame_texture(name, i), csf.get_frame_duration(name, i), i)
	return sf


