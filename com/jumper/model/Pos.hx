package com.jumper.model;
import com.jumper.maths.Vector2;
import nme.geom.Point;
import com.jumper.Constants;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Pos 
{
	public var pos:Vector2;
	public var posCorrect:Vector2;
	public var vel:Vector2;
	public var radius(get_radius,null):Float;
	public var halfExtents(get_halfExtents,null):Vector2;
	
	public var onGround:Bool;
	public var onGroundLast:Bool;
	
	public var scale:Float;
	
	public function new() 
	{
		pos = new Vector2();
		posCorrect = new Vector2();
		vel = new Vector2();

		scale = 1;
	}
	
	function get_radius():Float
	{
		return radius * scale;
	}
	
	function get_halfExtents():Vector2
	{
		return halfExtents.MulScalar(scale);
	}
	
	public function setExtents(width:Float, height:Float):Void
	{
		radius = width / 2;
		halfExtents = new Vector2(radius, height/2);
	}
	
	public function setScale(scaleIn:Float) 
	{
		scale = scaleIn;
	}
	
	public function getBounds():Rectangle
	{
		var half:Vector2 = get_halfExtents();
		return new Rectangle(pos.m_x - half.m_x, pos.m_y - half.m_y, half.m_x *2,half.m_y*2 );
	}
	
}