package com.jumper.mutator;

import com.jumper.geom.AABB;
import com.jumper.maths.Vector2;
import com.jumper.mutator.Move;
import nme.ui.Keyboard;
import com.jumper.maths.Scalar;
import com.jumper.level.Map;

class EnemyMove extends Move
{
	//how high does player jump?
	private static var kPlayerJumpVel:Float = 900 * 1.2;
	//how many frames do they flash for?
	private static var kHurtFrames:Int = 120;
	//controls how fast the player's velocity moves towards the target velocity
	//1 in one frame, 0 in never
	private static var kReachTargetScale:Float = 0.7;
	//how fast the player walks
	private static var kWalkSpeed:Float = 80;
	
	private var m_velTarget:Vector2;
	
	private var m_tileAABB:AABB;
	
	private var m_tryToMove:Bool;
	
	private var timeBeforeDirChange:Float = 0;
	private var currentDir:String = "right";
	
	public function new(map:Map, parent:EpicGameJam) 
	{
		super(map, parent);
		
		//temp storage for collision against tiles
		m_tileAABB = new AABB();
		m_velTarget = new Vector2();
	}
	
	override function processMove(time:Float):Void
	{
		badguyShuffle(time);

		//propels y by gravity
		currentPos.vel.AddYTo(Constants.kGravity);
		//clamp speed
		currentPos.vel.m_x = Scalar.Clamp(currentPos.vel.m_x, -Constants.kMaxSpeed, Constants.kMaxSpeed);
		currentPos.vel.m_y = Math.min(currentPos.vel.m_y, Constants.kMaxSpeed * 2);
		//carry out move
		super.processMove(time);
	}
	
	function badguyShuffle(time:Float):Void
	{
		timeBeforeDirChange += time;
		if (timeBeforeDirChange > 16.5) {
			timeBeforeDirChange = 0;
			currentDir = (currentDir == "left") ? "right" : "left";
		}
		
		
		m_tryToMove = false;
		
		var moveSpeed:Float = currentPos.onGround ? kWalkSpeed : kWalkSpeed / 2;
		
		m_velTarget.Clear();
		
		//standard walking controls
		if (currentDir == "left")
		{
			currentPos.vel.m_x -= moveSpeed;
			m_tryToMove = true;
		}
		if (currentDir == "right")
		{
			currentPos.vel.m_x += moveSpeed;
			m_tryToMove = true;
		}
		//standard jump controls (not in control in air)
		if (currentDir == "up")
		{
			if (currentPos.onGround)
				currentPos.vel.m_y -= kPlayerJumpVel;
		}
		
		//trace("player pos: " + currentPos.pos + ", player vel: " + currentPos.vel);
	}
	
	override function applyFriction():Bool
	{
		return !m_tryToMove;
	}
	
	override function hasWorldCollision()
	{
		return true;
	}
}

