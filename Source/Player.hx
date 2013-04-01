package;

import maths.Vector2;
import geom.AABB;
import geom.IAABB;
import level.Map;
import nme.ui.Keyboard;
import maths.Scalar;

class Player extends Character
{
	// how high do they jump?
	private static var kPlayerJumpVel:Float = 900*1.2;
	
	// how many frames does tha player flash for?
	private static var kHurtFrames:Int = 120;
	
	// controls how fast the player's velocity moves towards the target velocity
	// 1.0 = in one frame, 0 = never
	private static var kReachTargetScale:Float = 0.7;
	
	// how fast the player walks
	private static var kWalkSpeed:Float = 80;
	
	
	private var m_velTarget:Vector2;
	
	private var m_keyboard:KeyboardInput;
	
	private var m_tileAabb:AABB;

	private var m_tryToMove:Bool;
	private var m_flyMode:Bool;
	
	/// <summary>
	/// 
	/// </summary>	
	public function new( )
	{
		super();
		
		
		m_flyMode = false;
		
		// temporary storage for collision against tiles
		m_tileAabb = new AABB( );
					
		m_velTarget = new Vector2( );
	}
	
	/// <summary>
	/// Replaces the constructor since we can't have any parameters due to the CS4 symbol inheritance
	/// </summary>	
	public override function Initialise(pos:Vector2, map:Map, parent:EpicGameJam ):Vector2
	{
		var newPos:Vector2 = super.Initialise( pos, map, parent );
		
		m_velTarget = new Vector2( );
		m_keyboard = EpicGameJam.keyInput;
		
		return newPos;
	}
	
	
	/// <summary>
	/// 
	/// </summary>
	public function MakeTemporaryilyInvunerable( ):Void
	{
		m_hurtTimer = kHurtFrames;
	}
	
	
	/// <summary>
	/// 
	/// </summary>
	override function getHasWorldCollision()
	{
		return true;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public override function Update( dt:Float ):Void
	{
		// player contol
		KeyboardControl( dt );
		
		// integrate velocity
		if ( m_flyMode )
		{
			m_vel.MulScalarTo( 0.5 );
		}
		else
		{
			m_vel.AddYTo( Constants.kGravity );
		}
		
		// clamp speed
		m_vel.m_x = Scalar.Clamp( m_vel.m_x, -Constants.kMaxSpeed, Constants.kMaxSpeed );
		m_vel.m_y = Math.min( m_vel.m_y, Constants.kMaxSpeed*2 );
		
		super.Update( dt );
		
		if ( m_hurtTimer>0 )
		{
			this.visible = (m_hurtTimer&1) == 1;
			m_hurtTimer--;
		}
	}
	
	/// <summary>
	/// 
	/// </summary>	
	private function KeyboardControl( dt:Float ):Void
	{
		m_tryToMove = false;
		
		var moveSpeed:Float;
		
		if ( m_flyMode )
		{
			moveSpeed = kWalkSpeed*4;
		}
		else 
		{
			moveSpeed = m_OnGround ? kWalkSpeed : kWalkSpeed/2;
		}
		
		m_velTarget.Clear( );
		
		
		//
		// normal walking controls
		//
		
		if ( m_keyboard.getKeyDown( Keyboard.LEFT ) )
		{
			m_vel.m_x -= moveSpeed;
			m_tryToMove = true;
			
			// face left
			this.scaleX = -1;
		}
		if ( m_keyboard.getKeyDown( Keyboard.RIGHT ) )
		{
			m_vel.m_x += moveSpeed;
			m_tryToMove = true;
			
			// face right
			this.scaleX = 1;
		}
		
		if (m_flyMode)
		{
			if ( m_keyboard.getKeyDown( Keyboard.UP ) )
			{
				// fly mode controls
				m_vel.m_y -= moveSpeed;
				
				m_tryToMove = true;
			}
		}
		else
		{
			//
			// jump controls
			//
			
			if ( m_keyboard.getKeyDownTransition( Keyboard.UP ) )
			{
				if ( m_OnGround )
				{
					m_vel.m_y -= kPlayerJumpVel;
				}
			}
		}
	}
			
	/// <summary>
	/// 
	/// </summary>	
	override function getApplyFriction():Bool
	{
		return !m_tryToMove;
	}
}