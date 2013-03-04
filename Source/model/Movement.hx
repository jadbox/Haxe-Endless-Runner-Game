package model;
import nme.geom.Point;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Movement 
{
	public var vel:Point;
	public var maxSpeed:Float;
	
	public function new(maxSpeed:Float) 
	{
		vel = new Point();
		this.maxSpeed = maxSpeed;
	}
	
}