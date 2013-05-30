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
	public var animName:String;
	public var sheetName:String;
	public var currentFrame:Int;
	
	public function new() 
	{
		currentFrame = 0;
	}
	
}