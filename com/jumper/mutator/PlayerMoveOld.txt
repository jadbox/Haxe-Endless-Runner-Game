package com.jumper.mutator;

import model.Movement;
import model.MoveNode;
import model.Pos;
import nme.errors.Error;
import nme.ui.Keyboard;
import nme.Lib;
import model.Collider;

/**
 * ...
 * @author Greg Back
 */

class PlayerMoveOld implements ISystem
{
	//var models:Array<MoveNode>;
	var posList:Array<Pos>;
	var moveList:Array<Movement>;
	var colList:Array<Collider>;
	
	inline static var maxVel:Int = 50;
	
	public function new() 
	{
		//models = new Array<MoveNode>();
		
		moveList = new Array<Movement>();
		posList = new Array<Pos>();
		colList = new Array<Collider>();
	}
	public function add(entity:Entity):Void {
		posList.push(entity.fetch(Pos));
		moveList.push(entity.fetch(Movement));
		colList.push(entity.fetch(Collider));
	}
	public function update(time:Float):Void {
		var current:Int = 0;
		
		inline function movement():Void
		{
			var pos = posList[current];
			var movement = moveList[current];
			var collider = colList[current];
			if (EpicGameJam.keyInput.getKeyDown(Keyboard.A))
			{
				movement.x -= 5;
				if (movement.x < -maxVel) movement.x = -maxVel;
			}
			else if (EpicGameJam.keyInput.getKeyDown(Keyboard.D))
			{
				movement.x += 5;
				if (movement.x > maxVel) movement.x = maxVel;
			}
			else
			{
				if (movement.x > 0) {
					movement.x -= 5;
					if (movement.x < 0) movement.x = 0;
				}
				if (movement.x < 0) {
					movement.x += 5;
					if (movement.x > 0) movement.x = 0;
				}
			}
			var jumping:Bool;
			var colliding:Bool;
			if (EpicGameJam.keyInput.getKeyDown(Keyboard.W))
				jumping = true;
			else
				jumping = false;
			if (collider.colliders.length > 0)
				colliding = true;
			else
				colliding = false;
				
			if (jumping && colliding)
				movement.y -= 20;
			
			if (!colliding) {
				movement.y += 10;
			}else if(movement.y > 0){
				movement.y = 0;
			}
			/*if (movement.vel.y < 0 && !colliding) {
				movement.vel.y += 20;
				trace("not colliding");
				//if (movement.vel.y > 0) movement.vel.y = 0;
			}
			if (movement.vel.y > 0 && !colliding) {
				movement.vel.y -= 20;
				if (movement.vel.y < 0) movement.vel.y = 0;
			}*/
			
			pos.x += movement.x;
			pos.y += movement.y;
			
			if (colliding && !jumping) {
				for (hit in collider.colliders) {
					if (hit.col.kind == "ground") {
						trace("hit: " + hit.col.kind + " " + hit.pos.y);
						pos.y = hit.pos.y - 170;
					}
				}
				//pos.y = Lib.current.stage.stageHeight - 170;
			}
		}
		
		while (current < posList.length) {
			movement();
			current++;
		}
	}
	
	/* INTERFACE ISystem */
	
	public function remove(e:Entity):Void 
	{
		
	}
}