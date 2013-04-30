package com.jumper.mutator;

import com.jumper.geom.AABB;
import com.jumper.maths.Vector2;
import com.jumper.mutator.Move;
import nme.display.Sprite;
import nme.ui.Keyboard;
import com.jumper.maths.Scalar;
import com.jumper.level.Map;

class PlayerMove extends Move
{
	//how high does player jump?
	private static var kPlayerJumpVel:Float = 450;
	//how many frames do they flash for?
	private static var kHurtFrames:Int = 120;
	//controls how fast the player's velocity moves towards the target velocity
	//1 in one frame, 0 in never
	private static var kReachTargetScale:Float = 0.4;
	//how fast the player walks
	private static var kWalkSpeed:Float = 40;
	
	private var m_velTarget:Vector2;
	private var m_keyboard:KeyboardInput;
	
	private var m_tileAABB:AABB;
	
	private var m_hurtTimer:Int;
	private var m_tryToMove:Bool;
	private var m_flyMode:Bool;
	
	public function new(map:Map, parent:EpicGameJam) 
	{
		super(map, parent);
		
		m_flyMode = false;
		m_hurtTimer = 0;
		//temp storage for collision against tiles
		m_tileAABB = new AABB();
		m_velTarget = new Vector2();
		m_keyboard = EpicGameJam.keyInput;
	}
	
	public function MakeTemporaryilyInvunerable( ):Void
	{
		m_hurtTimer = kHurtFrames;
	}
	
	override function hasWorldCollision()
	{
		return true;
	}
	
	override function processMove(time:Float):Void
	{
		keyboardControl(time);
		//integrate velocity
		if (m_flyMode)
		{
			//cuts velocity while in air
			currentPos.vel.MulScalarTo(0.5);
		}else 
		{
			//propels y by gravity
			currentPos.vel.AddYTo(Constants.kGravity);
		}
		//clamp speed
		currentPos.vel.m_x = Scalar.Clamp(currentPos.vel.m_x, -Constants.kMaxSpeed, Constants.kMaxSpeed);
		currentPos.vel.m_y = Math.min(currentPos.vel.m_y, Constants.kMaxSpeed * 2);
		//carry out move
		super.processMove(time);
		if (m_hurtTimer > 0)
		{
			//do hurt stuff
			//this.visible = (m_hurtTimer&1) == 1;
			m_hurtTimer--;
		}
	}
	
	function keyboardControl(time:Float):Void
	{
		m_tryToMove = false;
		
		var moveSpeed:Float = 0;
		if (m_flyMode)
			moveSpeed = kWalkSpeed * 4;
		else
			moveSpeed = currentPos.onGround ? kWalkSpeed : kWalkSpeed / 2;
		
		m_velTarget.Clear();
		
		//standard walking controls
		if (m_keyboard.getKeyDown(Keyboard.LEFT))
		{
			currentPos.vel.m_x -= moveSpeed;
			m_tryToMove = true;
			//face left
			//this.scaleX = -1;
		}
		if (m_keyboard.getKeyDown(Keyboard.RIGHT))
		{
			currentPos.vel.m_x += moveSpeed;
			m_tryToMove = true;
			//face right
			//this.scaleX = 1;
		}
		if (m_flyMode)
		{
			if (m_keyboard.getKeyDown(Keyboard.UP))
			{
				//fly mode controls (in control in air)
				currentPos.vel.m_y -= moveSpeed;
				m_tryToMove = true;
			}
		}else 
		{
			//standard jump controls (not in control in air)
			if (m_keyboard.getKeyDownTransition(Keyboard.UP))
			{
				if (currentPos.onGround)
					currentPos.vel.m_y -= kPlayerJumpVel;
			}
		}
		
		//trace("player pos: " + currentPos.pos + ", player vel: " + currentPos.vel);
	}
	
	override function applyFriction():Bool
	{
		return !m_tryToMove;
	}
}

