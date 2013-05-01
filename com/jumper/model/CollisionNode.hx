package com.jumper.model;

/**
 * ...
 * @author Jonathan Dunlap
 */

class CollisionNode 
{
	public var col:Collider;
	public var pos:Pos;
	
	public function new(col:Collider, pos:Pos) 
	{
		this.col = col;
		this.pos = pos;
	}
	
}