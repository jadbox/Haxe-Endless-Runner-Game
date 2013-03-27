package;

import nme.display.MovieClip;
import maths.Vector2;
import level.Map;
import geom.IAABB;


public class MoveableObject extends MovieClip implements IAABB, ICircle
{
	// friction with ground - 1=totally sticky, 0=ice
	private const kGroundFriction:Float = 0.6;
	
	protected var m_pos:Vector2;
	protected var m_posCorrect:Vector2;
	protected var m_vel:Vector2;
	protected var m_radius:Float;
	protected var m_halfExtents:Vector2;
	
	protected var m_platformer:EpicGameJam;
	protected var m_map:Map;
	
	protected var m_contact:Contact;
	
	private var m_onGround:Bool;
	private var m_onGroundLast:Bool;
	
	protected var m_dead:Bool;
	
	public function MoveableObject( )
	{
		super( );
		
		// get collsion radius
		m_radius = Constants.kPlayerWidth/2;
		m_halfExtents = new Vector2( m_radius, m_radius );
		
		m_vel = new Vector2( );
		m_posCorrect = new Vector2( );
		
		m_contact = new Contact( );
		
		m_dead = false;
	}
	
	/// <summary>
	/// Replaces the constructor since we can't have any parameters due to the CS4 symbol inheritance
	/// </summary>	
	public function Initialise( pos:Vector2, map:Map, parent:EpicGameJam ):Vector2
	{
		// position in the centre of the tile in the X and resting on the bottom of the tile in the Y
		if ( m_TileMapped )
		{
			pos.m_x += Constants.kTileSize/2;
			pos.m_y += Constants.kTileSize-m_radius;
		}
		
		m_Pos = pos;
		m_platformer = parent;
		m_map = map;
		
		return pos;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_Radius(getRad,null):Float
	function getRad()
	{
		return m_radius;
	}
	
	/// <summary>
	/// 
	/// </summary>
	public var m_Centre(getCentre,null ):Vector2
	function getCentre()
	{
		return m_pos;
	}
	
	/// <summary>
	/// 
	/// </summary>
	public var m_HalfExtents(getHalfExt, null ):Vector2
	function getHalfExt()
	{
		return m_halfExtents;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_Pos(getPos,setPos):Vector2
	function getPos()
	{
		return m_pos;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	function setPos( pos:Vector2 ):void
	{
		m_pos = pos;
		
		// update visual
		this.x = pos.m_x;
		this.y = pos.m_y;
	}
	
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_Vel(getVel,setVel ):Vector2
	function getVel()
	{
		return m_vel;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	function setVel( vel:Vector2 ):void
	{
		m_vel = vel;
	}
	
	/// <summary>
	/// 
	/// </summary>
	public var m_OnGround(getOnGround,null ):Bool
	function getOnGround()
	{
		return m_onGround;
	}
	
	/// <summary>
	/// 
	/// </summary>
	public var m_OnGroundLast(getOnGroundLast,null ):Bool
	function getOnGroundLast()
	{
		return m_onGroundLast;
	}
	
	/// <summary>
	/// 
	/// </summary>
	public var m_TileMapped(getTileMapped,null ):Bool
	function getTileMapped()
	{
		return true;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_Dead(getDead,setDead ):Bool
	function getDead()
	{
		return m_dead;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	function setDead( dead:Bool ):void
	{
		m_dead = dead;
	}
	
	/// <summary>
	/// Apply gravity, do collision and integrate position
	/// </summary>	
	public function Update( dt:Float ):void
	{
		if ( m_ApplyGravity )
		{
			m_vel.AddYTo( Constants.kGravity );
			
			// clamp max speed
			m_vel.m_y = Math.min( m_vel.m_y, Constants.kMaxSpeed*2 );
		}
		
		if ( m_HasWorldCollision )
		{
			// do complex world collision
			Collision( dt );
		}
		
		// integrate position
		m_pos.MulAddScalarTo( m_vel.Add(m_posCorrect), dt );
		
		// force the setter to act
		m_Pos = m_pos;
		m_posCorrect.Clear( );
	}
	
	/// <summary>
	/// 
	/// </summary>
	public var m_HasWorldCollision(getHasWorldCollision,null ):Bool
	function getHasWorldCollision()
	{
		return false;
	}
	
	/// <summary>
	/// 
	/// </summary>
	var m_ApplyGravity(getApplyGravity, null ):Bool
	function getApplyGravity()
	{
		return false;
	}
	
	/// <summary>
	/// 
	/// </summary>
	var m_ApplyFriction(getApplyFriction,null ):Bool
	function getApplyFriction()
	{
		return false;
	}
	
	/// <summary>
	/// 
	/// </summary>
	public var m_ForceUpdate( getForceUpdate,null):Bool
	function getForceUpdate()
	{
		return false;
	}
	
	/// <summary>
	/// 
	/// </summary>
	function PreCollisionCode( ):void
	{
		m_onGroundLast = m_onGround;
		m_onGround = false;
	}
	
	/// <summary>
	/// 
	/// </summary>
	function PostCollisionCode( ):void
	{
	}
	
	/// <summary>
	/// Do collision detection and response for this object
	/// </summary>	
	function Collision( dt:Float ):void
	{
		// where are we predicted to be next frame?
		var predictedPos:Vector2 = Platformer.m_gTempVectorPool.AllocateClone( m_pos ).MulAddScalarTo( m_vel, dt );
		
		// find min/max
		var min:Vector2 = m_pos.Min( predictedPos );
		var max:Vector2 = m_pos.Max( predictedPos );
		
		// extend by radius
		min.SubFrom( m_halfExtents );
		max.AddTo( m_halfExtents );
		
		// extend a bit more - this helps when player is very close to boundary of one map cell
		// but not intersecting the next one and is up a ladder
		min.SubFrom( Constants.kExpand );
		max.AddTo( Constants.kExpand );
		
		PreCollisionCode( );
		
		m_map.DoActionToTilesWithinAabb( min, max, InnerCollide, dt );
		
		PostCollisionCode( );
	}
	
	/// <summary>
	/// Inner collision response code
	/// </summary>	
	function InnerCollide(tileAabb:AABB, tileType:Int, dt:Float, i:Int, j:Int ):void
	{
		// is it collidable?
		if ( Map.IsTileObstacle( tileType ) )
		{
			// standard collision responce
			var collided:Bool = Collide.AabbVsAabb( this, tileAabb, m_contact, i, j, m_map );
			if ( collided )
			{
				CollisionResponse( m_contact.m_normal, m_contact.m_dist, dt );
			}
		}
	}
	
	/// <summary>
	/// 
	/// </summary>	
	function LandingTransition( ):void
	{
	}
	
	/// <summary>
	/// Collision Reponse - remove normal velocity
	/// </summary>	
	function CollisionResponse( normal:Vector2, dist:Float, dt:Float ):void
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
	
	/// <summary>
	/// Is the given candidate heading towards towardsPoint? 
	/// </summary>
	static public function HeadingTowards( towardsPoint:Vector2, candidate:MoveableObject ):Bool
	{
		var deltaX:Float = towardsPoint.m_x-candidate.m_Pos.m_x;
		var headingTowards:Bool = deltaX*candidate.m_Vel.m_x>0;
		
		return headingTowards;
	}
}

