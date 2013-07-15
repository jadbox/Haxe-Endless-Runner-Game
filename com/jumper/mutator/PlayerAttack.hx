package com.jumper.mutator;

import com.jumper.Entity;
import com.jumper.model.Pos;
import com.jumper.TouchInput;
import com.jumper.EpicGameJam;
import com.jumper.geom.AABB;
import nme.utils.Timer;
/**
 * ...
 * @author gback
 */

class PlayerAttack extends Attack
{
	public var isActive:Bool = false;
	
	private var touch:TouchInput;
	private var isTapped:Bool = false;
	
	private var attackTimeRemaining:Float = 0;
	
	
	public function new() 
	{
		super();
		touch = EpicGameJam.touchInput;
		touch.tapListeners.push(handleTap);
	}
	
	function handleTap():Void
	{
		trace("Player Tap");
		isTapped = true;
		//if(!isActive) generateAttack();
	}
	
	function generateAttack():Void
	{
		//trace("attack generated");
		isActive = true;
		var attackPos:Pos = new Pos();
		attackPos.setExtents(15, 15);
		attackPos.pos = currentPos.pos.Clone();
		attackPos.pos.AddXTo(80);
		currentAtk.pos = attackPos;
		attackTimeRemaining = 2.2;
		//currentPos
	}
	
	override public function update(time:Float):Void 
	{
		var current:Int = 0;
		while (current < posList.length)
		{
			currentPos = posList[current];
			currentAtk = atkList[current];
			processAttack(time);
			current++;
		}
		isTapped = false;
	}
	
	function processAttack(time:Float):Void
	{
		//trace("processing attack");
		if (isTapped && !isActive) generateAttack();
		if (isActive && attackTimeRemaining > 0) {
			attackTimeRemaining -= time;
			//process collision
			//collider rect
			currentAtk.pos.pos = currentPos.pos.Clone();
			currentAtk.pos.pos.AddXTo(80);
			trace("draw attack");
			Util.DebugDraw(currentAtk.pos);
			
		}else {
			isActive = false;
		}
	}
	
	override public function add(entity:Entity):Void 
	{
		super.add(entity);
	}
	
	override public function remove(entity:Entity):Void 
	{
		super.remove(entity);
	}
	
}