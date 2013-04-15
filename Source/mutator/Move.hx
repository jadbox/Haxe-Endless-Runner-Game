package mutator;
import geom.AABB;
import model.Movement;
import model.MoveNode;
import model.Pos;
import nme.errors.Error;
import maths.Vector2;
import level.Map;
import geom.Contact;

/**
 * ...
 * @author Greg Back
 */

class Move implements ISystem implements IAABB
{
	var currentEntity:Int = 0;
	
	var currentPos:Pos;
	
	//var models:Array<MoveNode>;
	var posList:Array<Pos>;
	var velList:Array<Movement>;
	
	var m_platformer:EpicGameJam;
	var m_map:Map;
	var m_contact:Contact;
	
	public function new(map:Map, parent:EpicGameJam) 
	{
		//models = new Array<MoveNode>();
		
		velList = new Array<Pos>();
		posList = new Array<Movement>();
		
		
	}
	public function remove(entity:Entity):Void {
		posList.push(entity.fetch(Pos));
		moveList.push(entity.fetch(Movement));
	}
	public function add(entity:Entity):Void {
		var pos:Pos = entity.fetch(Pos);
		pos.radius = Constants.kPlayerWidth / 2;
		pos.halfExtents = new Vector2( pos.radius, pos.radius );
		posList.push(pos);
		moveList.push(entity.fetch(Movement));
		
		
	}
	
	public function update(time:Float):Void {
		while (currentEntity < posList.length) {
			//var pos  = posList[current];
			//var movement = moveList[current];
			//pos.x += movement.x;
			//pos.y += movement.y;
			currentPos = posList[currentEntity];
			processMove(time);
			currentEntity++;
		}
	}
	
	function processMove(time:Float):Void
	{
		
		//apply gravity
		if (applyGravity()) {
			currentPos.vel.AddYTo(Constants.kGravity);
			//clamp max fall speed
			currentPos.vel.m_y = Math.min(Constants.kMaxSpeed*2);
		}
		if (hasWorldCollision())
			collide(time)
	}
	
	function collide(time:Float):Void
	{
		var predictedPos:Vector2 = EpicGameJam.m_gTempVectorPool.AllocateClone(currentPos.pos).MulAddScalarTo(currentPos.vel, time);
		
		//find min/max
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
		pos.onGroundLast = currentPos.onGround;
		pos.onGround = false;
		
		//collision
		m_map.DoActionToTilesWithinAabb(min, max, innerCollide, time);
		
		//post collision
	}
	
	function innerCollide(tileAabb:AABB, tileType:Int, time:Float, i:Int, j:Int):Void
	{
		// is it collidable?
		if ( Map.IsTileObstacle( tileType ) )
		{
			// standard collision responce
			var a
			var collided:Bool = Collide.AabbVsAabb( this, tileAabb, m_contact, i, j, m_map );
			if ( collided )
			{
				collisionResponse( m_contact.m_normal, m_contact.m_dist, dt );
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
	function collisionResponse( normal:Vector2, dist:Float, dt:Float ):Void
	{
		// get the separation and penetration separately, this is to stop pentration 
		// from causing the objects to ping apart
		var separation:Float = Math.max( dist, 0 );
		var penetration:Float = Math.min( dist, 0 );
		
		// compute relative normal velocity require to be object to an exact stop at the surface
		var nv:Float = m_vel.Dot( normal ) + separation/dt;
		
		// accumulate the penetration correction, this is applied in Update() and ensures
		// we don't add any energy to the system
		m_posCorrect.SubFrom( normal.MulScalar( penetration/dt ) );
		
		if ( nv<0 )
		{
			// remove normal velocity
			m_vel.SubFrom( normal.MulScalar( nv ) );
			
			// is this some ground?
			if ( normal.m_y<0 )
			{
				m_onGround = true;
				
				// friction
				if ( m_ApplyFriction )
				{
					// get the tanget from the normal (perp vector)
					var tangent:Vector2 = normal.m_Perp;
					
					// compute the tangential velocity, scale by friction
					var tv:Float = m_vel.Dot( tangent )*kGroundFriction;
					
					// subtract that from the main velocity
					m_vel.SubFrom( tangent.MulScalar( tv ) );
				}
				
				if (!m_onGroundLast)
				{
					// this transition occurs when this object 'lands' on the ground
					LandingTransition( );
				} 
			}
		}
	}
	
	function applyGravity():Bool
	{
		return true;
	}
	
	function hasWorldCollision():Bool
	{
		
	}
}