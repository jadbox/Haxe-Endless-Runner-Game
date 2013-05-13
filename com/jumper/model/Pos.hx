package com.jumper.model;
import com.jumper.maths.Vector2;
import nme.geom.Point;
import com.jumper.Constants;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Pos 
{
	public var pos:Vector2;
	public var posCorrect:Vector2;
	public var vel:Vector2;
	public var radius:Float;
	public var halfExtents:Vector2;
	
	public var onGround:Bool;
	public var onGroundLast:Bool;
	
	public function new(width:Float = 0, height:Float = 0) 
	{
		pos = new Vector2();
		posCorrect = new Vector2();
		vel = new Vector2();
		radius = Constants.kTileSize;
		halfExtents = new Vector2();
		
	}
	
	public function setExtents(width:Float, height:Float):Void
	{
		radius = width / 2;
		halfExtents = new Vector2(radius, height/2);
	}
	
}