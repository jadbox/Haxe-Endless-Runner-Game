package model;
import maths.Vector2;
import nme.geom.Point;

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
	
	public function new() 
	{
		pos = new Vector2();
		posCorrect = new Vector2();
		vel = new Vector2();
		radius = Constants.kPlayerWidth / 2;
		halfExtents = new Vector2();
	}
	
}