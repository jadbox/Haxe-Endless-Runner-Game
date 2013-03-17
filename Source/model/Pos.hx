package model;
import maths.Vector2;
import nme.geom.Point;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Pos 
{
	public var vec:Vector2;
	public var x:Int;
	public var y:Int;
	public var rotation:Float;
	
	public function new() 
	{
		vec = new Vector2();
		x = y = 0;
		rotation = 0;
	}
	
}