package com.jumper.mutator;

import com.jumper.geom.AABB;
import com.jumper.model.Movement;
import com.jumper.model.MoveNode;
import com.jumper.model.Pos;
import nme.errors.Error;
import com.jumper.maths.Vector2;
import com.jumper.level.Map;
import com.jumper.geom.Contact;
import com.jumper.geom.Collide;
import com.jumper.geom.IAABB;
import com.jumper.level.TileTypes;

/**
 * ...
 * @author Greg Back
 */

class Move implements ISystem, implements IAABB
{
	// friction with ground - 1=totally sticky, 0=ice
	private static var kGroundFriction:Float = 0.6;
	
	var currentEntity:Int = 0;
	
	var currentPos:Pos;
	
	//var models:Array<MoveNode>;
	var posList:Array<Pos>;
	//var moveList:Array<Movement>;
	
	var m_platformer:EpicGameJam;
	var m_map:Map;
	var m_contact:Contact;
	
	public function new(map:Map, parent:EpicGameJam) 
	{
		//models = new Array<MoveNode>();
		m_map = map;
		m_platformer = parent;
		posList = new Array<Pos>();
		//moveList = new Array<Movement>();
		
		//should be moved to Pos
		m_contact = new Contact( );
	}
	public function remove(entity:Entity):Void {
		posList.push(entity.fetch(Pos));
		//moveList.push(entity.fetch(Movement));
	}
	public function add(entity:Entity):Void {
		var pos:Pos = entity.fetch(Pos);
		//pos.radius = Constants.kPlayerWidth / 2;
		//pos.halfExtents = new Vector2( pos.radius, Constants.kPlayerHeight / 2 );
		posList.push(pos);
		
	}
	
	public function update(time:Float):Void {
		currentEntity = 0;
		while (currentEntity < posList.length) {
			currentPos = posList[currentEntity];
			processMove(time);
			currentEntity++;
		}
	}
	
	function processMove(time:Float):Void
	{
		//trace("time is processing");
		//apply gravity
		if (applyGravity()) {
			currentPos.vel.AddYTo(Constants.kGravity);
			//clamp max fall speed
			currentPos.vel.m_y = Math.min(currentPos.vel.m_y, Constants.kMaxSpeed*2);
		}
		if (hasWorldCollision()) {
			//do complex world collision
			collide(time);
		}
		//integrate position
		currentPos.pos.MulAddScalarTo(currentPos.vel.Add(currentPos.posCorrect), time);
		
		
		
		currentPos.posCorrect.Clear();
	}
	
	function collide(time:Float):Void
	{
		var predictedPos:Vector2 = EpicGameJam.m_gTempVectorPool.AllocateClone(currentPos.pos).MulAddScalarTo(currentPos.vel, time);
		
		//find min/max area that is collidable
		var min:Vector2 = currentPos.pos.Min(predictedPos);
		var max:Vector2 = currentPos.pos.Max(predictedPos);
		//extend by radius
		min.SubFrom(currentPos.halfExtents);
		max.AddTo(currentPos.halfExtents);
		// extend a bit more - this helps when player is very close to boundary of one map cell
		// but not intersecting the next one and is up a ladder
		min.SubFrom(Constants.kExpand);
		max.AddTo(Constants.kExpand);
		
		//pre collision code
		currentPos.onGroundLast = currentPos.onGround;
		currentPos.onGround = false;
		
		//collision
		m_map.DoActionToTilesWithinAabb(min, max, innerCollide, time);
		
		//post collision
	}
	//tileAabb is the AABB(boundaries) of the tile
	function innerCollide(tileAabb:AABB, tileType:Int, time:Float, i:Int, j:Int):Void
	{
		// is it collidable?
		if ( Map.IsTileObstacle( tileType ))
		{
			// standard collision responce
			//trace("tileAabb: " + tileAabb + ", m_contact: " + m_contact);
			var collided:Bool = Collide.AabbVsAabb( this, tileAabb, m_contact, i, j, m_map );
			if ( collided )
			{
				collisionResponse( m_contact.m_normal, m_contact.m_dist, time );
			}
		}
		
	}
	//implementing IAABB
	public function getCentre():Vector2
	{
		return currentPos.pos;
	}
	
	public function getHalfExtents():Vector2
	{
		return currentPos.halfExtents;
	}
	
	/// <summary>
	/// Collision Reponse - remove normal velocity
	/// </summary>	
	function collisionResponse( normal:Vector2, dist:Float, time:Float ):Void
	{
		// get the separation and penetration separately, this is to stop pentration 
		// from causing the objects to ping apart
		var separation:Float = Math.max( dist, 0 );
		var penetration:Float = Math.min( dist, 0 );
		
		//compute the relative normal velocity required to bring object to an exact stop at the surface
		var nv:Float = currentPos.vel.Dot(normal) + separation / time;
		
		//accumulate the penetration correction, this is applied in update() and ensures we don't
		//add any energy to the system
		currentPos.posCorrect.SubFrom(normal.MulScalar(penetration / time));
		if (nv < 0)
		{
			//remove normal velocity(stops it)
			currentPos.vel.SubFrom(normal.MulScalar(nv));
			//is this ground?
			if (normal.m_y < 0)
			{
				currentPos.onGround = true;
				//friction
				if (applyFriction())
				{
					//get the tangent from the normal (perpendicular vector)
					var tangent:Vector2 = normal.m_Perp;
					//compute the tangential velocity, then scale by friction
					var tv:Float = currentPos.vel.Dot(tangent) * kGroundFriction;
					//subtract that from the main velocity
					currentPos.vel.SubFrom(tangent.MulScalar(tv));
				}
				
				if (!currentPos.onGroundLast)
					landingTransition();
			}
		}
	}
	
	function landingTransition( ):Void
	{
	}
	
	function applyGravity():Bool
	{
		return false;
	}
	
	function applyFriction():Bool
	{
		return false;
	}
	
	function hasWorldCollision():Bool
	{
		return false;
	}
}