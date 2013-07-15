package com.jumper.mutator;

import com.jumper.ISystem;
import com.jumper.Entity;
import com.jumper.model.Atk;
import com.jumper.model.Pos;
/**
 * ...
 * @author gback
 */

class Attack implements ISystem
{
	
	var currentPos:Pos;
	var posList:Array<Pos>;
	var currentAtk:Atk;
	var atkList:Array<Atk>;

	public function new() 
	{
		posList = new Array<Pos>();
		atkList = new Array<Atk>();
	}
	
	/* INTERFACE com.jumper.ISystem */
	
	public function update(time:Float):Void 
	{
		
	}
	
	public function add(entity:Entity):Void 
	{
		entity.destructionListener(function(e:Entity) { remove(e); } );
		var pos:Pos = entity.fetch(Pos);
		posList.push(pos);
		var atk:Atk = entity.fetch(Atk);
		atkList.push(atk);
	}
	
	public function remove(entity:Entity):Void 
	{
		
	}
	
}