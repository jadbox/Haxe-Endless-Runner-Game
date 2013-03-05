package model;
import nme.geom.Point;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Movement 
{
	public var x:Int;
	public var y:Int;
	public var maxSpeed:Float;
	
	public function new(maxSpeed:Float=1) 
	{
		x = y = 1; // change to 0
		this.maxSpeed = maxSpeed;
	}
	
}