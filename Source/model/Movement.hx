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
	
	public function new(maxSpeed:Float=1) 
	{
		vel = new Point(maxSpeed,maxSpeed);
		this.maxSpeed = maxSpeed;
	}
	
}