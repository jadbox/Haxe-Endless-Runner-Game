package com.jumper.mutator;

import model.Pos;
import model.Movement;
import model.View;
import nme.Lib;
/**
 * ...
 * @author gback
 */

class Platform implements ISystem
{
	var posList:Array<Pos>;
	var moveList:Array<Movement>;
	var viewList:Array<View>;
	

	public function new() 
	{
		posList = new Array<Pos>();
		moveList = new Array<Movement>();
		//viewList = new Array<View>();
	}
	
	/* INTERFACE ISystem */
	
	public function update(time:Float):Void 
	{
		var current = 0;
		while (current < posList.length)
		{
			var pos = posList[current];
			var movement = moveList[current];
			
			movement.vel.x -= 2;
			
			pos.pt.x += movement.vel.x;
			pos.pt.y += movement.vel.y;
			
			current++;
		}
	}
	
	public function start():Void 
	{
		
	}
	
	public function stop():Void 
	{
		
	}
	
	public function add(e:Entity):Void 
	{
		var pos = e.fetch(Pos);
		pos.pt.x = Lib.current.stage.stageWidth;
		pos.pt.y = Lib.current.stage.stageHeight * Math.random();
		var movement = e.fetch(Movement);
		
		posList.push(pos);
		moveList.push(movement);
		
		//viewList.push(e.fetch(View));
	}
	
}