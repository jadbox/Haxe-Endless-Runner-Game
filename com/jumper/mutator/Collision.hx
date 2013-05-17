package com.jumper.mutator;
import com.jumper.model.Movement;
import com.jumper.model.Pos;
import nme.errors.Error;
import com.jumper.model.View;
import com.jumper.model.Collider;

/**
 * ...
 * @author Gback
 */

class Collision implements ISystem
{
	//var models:Array<MoveNode>;
	var viewList:Array<View>;
	var colList:Array<Collider>;
	var posList:Array<Pos>;
	
	public function new() 
	{
		//models = new Array<MoveNode>();
		
		viewList = new Array<View>();
		colList = new Array<Collider>();
		posList = new Array<Pos>();
	}
	public function add(entity:Entity):Void {
		viewList.push(entity.fetch(View));
		colList.push(entity.fetch(Collider));
		posList.push(entity.fetch(Pos));
	}
	public function start():Void {
		
	}
	public function stop():Void {
		
	}
	public function update(time:Float):Void {

	}
	
	/* INTERFACE ISystem */
	
	public function remove(e:Entity):Void 
	{
		
	}
}