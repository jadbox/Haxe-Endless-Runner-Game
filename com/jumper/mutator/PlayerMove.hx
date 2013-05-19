package com.jumper.mutator;

import com.jumper.geom.AABB;
import com.jumper.maths.Vector2;
import com.jumper.model.Pos;
import com.jumper.mutator.Move;
import com.jumper.TouchInput;
import nme.display.Sprite;
import nme.ui.Keyboard;
import com.jumper.maths.Scalar;
import com.jumper.level.Map;
import com.jumper.EpicGameJam;
import com.jumper.Constants;
import com.jumper.Engine;
import com.jumper.Entity;
import com.jumper.geom.Collide;
import com.jumper.model.Stats;

using Lambda;

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
    
    private var m_touch:TouchInput;
	
	private var m_tileAABB:AABB;
	
	private var m_hurtTimer:Int;
	private var m_tryToMove:Bool;
	private var m_flyMode:Bool;
    
    private var tapped:Bool = false;
	
	private var swipes:Array<String>;
	
	private var direction:String = "none";
	
	public function new(map:Map, parent:EpicGameJam) 
	{
		super(map, parent);
		
		m_flyMode = false;
		m_hurtTimer = 0;
		//temp storage for collision against tiles
		m_tileAABB = new AABB();
		m_velTarget = new Vector2();
		m_keyboard = EpicGameJam.keyInput;

        m_touch = EpicGameJam.touchInput;
        m_touch.tapListeners.push(handleTap);
        
		swipes = new Array<String>();
		m_touch.swipeListeners.push(handleSwipe);
	}
	
	function handleSwipe(dir:String):Void
	{
		//swipes.push(dir);
		direction = dir;
	}
    
    function handleTap():Void
    {
        tapped = true;
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
        touchControl(time);
		//keyboardControl(time);
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
    
    function touchControl(time:Float):Void
    {
        m_tryToMove = false;
        var moveSpeed:Float = 0;
        moveSpeed = currentPos.onGround ? kWalkSpeed : kWalkSpeed / 2;
        
        m_velTarget.Clear();
		var pi = Math.PI;
		//angle controls
        //LEFT
        /*if (m_touch.getCurAngle() >= pi/2 && m_touch.getCurAngle() <= pi) {
            currentPos.vel.m_x -= moveSpeed;
			m_tryToMove = true;
        }
        //RIGHT
        if (m_touch.getCurAngle() > 0 && m_touch.getCurAngle() < pi/2) {
            currentPos.vel.m_x += moveSpeed;
			m_tryToMove = true;
        }*/
		//direction controls
		/*while (swipes.length > 0) {
			switch(swipes.pop()) {
				case "left":
					currentPos.vel.m_x -= moveSpeed;
					m_tryToMove = true;
				case "right":
					currentPos.vel.m_x -= moveSpeed;
					m_tryToMove = true;
				case "up":
				case "down":
				default:
			}
		}*/
		switch(direction) {
			case "left":
				currentPos.vel.m_x -= moveSpeed;
				m_tryToMove = true;
			case "right":
				currentPos.vel.m_x += moveSpeed;
				m_tryToMove = true;	
		}
        if (tapped) {
            if (currentPos.onGround)
                currentPos.vel.m_y -= kPlayerJumpVel;
        }
        tapped = false;
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
        #if android
        //LEFT
        if (m_touch.getCurAngle() > 0 && m_touch.getCurAngle() < Constants.kTwoPi) {
            currentPos.vel.m_x -= moveSpeed;
			m_tryToMove = true;
        }
        //RIGHT
        if (m_touch.getCurAngle() > Constants.kTwoPi) {
            currentPos.vel.m_x -= moveSpeed;
			m_tryToMove = true;
        }
        if (tapped) {
            if (currentPos.onGround)
                currentPos.vel.m_y -= kPlayerJumpVel;
        }
        tapped = false;
        #else
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
        #end
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
	}
	
	override function collide(time:Float):Void
	{
		super.collide(time);
		EpicGameJam.engine.getEntitiesById(3).iter(function(e:Entity) {
			var enemyPos:Pos = e.fetch(Pos);
			//trace("enemyPos " + enemyPos.pos.m_x + " , " + enemyPos.pos.m_x + "half extents " + enemyPos.halfExtents.m_x + " , " + enemyPos.halfExtents.m_y);
			var enemyAabb:AABB = new AABB(enemyPos.pos, enemyPos.halfExtents);
			var collided:Bool = Collide.AabbVsAabb( this, enemyAabb, m_contact, Map.WorldCoordsToTileX(enemyPos.pos.m_x), Map.WorldCoordsToTileY(enemyPos.pos.m_y), m_map, false );
			//if (collided) trace("contact normal " + m_contact.m_normal + " dist " + m_contact.m_dist);
			//else trace("did not collide");
			collisionResponse(m_contact.m_normal, m_contact.m_dist, time);
			if (m_contact.m_dist <= 1) {
				var enemyStats:Stats = e.fetch(Stats);
				if(null != enemyStats) enemyStats.health -= 2;
			}
		});
	}
	
	override function innerCollide(tileAabb:AABB, tileType:Int, time:Float, i:Int, j:Int):Void
	{
		super.innerCollide(tileAabb, tileType, time, i, j);
		//lets loop through a collidable list of enemies to see if we are hitting one
		
	}
	
	override function applyFriction():Bool
	{
		return !m_tryToMove;
	}
	
}

