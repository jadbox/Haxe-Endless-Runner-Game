package com.jumper.model;
import nme.display.Tilesheet;

/**
 * ...
 * @author gback
 */

enum SpriteId {
	MaleCharacter;
}
 
class SpriteAnim 
{
	public var spriteId:SpriteId;
	public var anim:String;
	public var currentFrame:Int;
	
	public function new() 
	{
		currentFrame = 0;
	}
	
}