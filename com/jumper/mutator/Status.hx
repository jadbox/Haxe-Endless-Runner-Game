package com.jumper.mutator;

import com.jumper.ISystem;
import com.jumper.model.Stats;
import com.jumper.Entity;
import com.jumper.EpicGameJam;
import nme.errors.Error;

using Lambda;
/**
 * ...
 * @author gback
 */

class Status implements ISystem
{
	
	private var statsList:Array<Stats>;
	private var entityList:Array<Entity>;
	
	var current:Int;
	
	public function new() 
	{
		statsList = new Array<Stats>();
		entityList = new Array<Entity>();
	}
	
	/* INTERFACE com.jumper.ISystem */
	
	public function update(time:Float):Void 
	{
		current = 0;
		while (current < entityList.length) {
			trace(statsList[current]);
			trace(entityList[current]);
			if (statsList[current].health < 1) entityList[current].destroy();
			else current++;
		}
		
	}
	
	public function add(e:Entity):Void 
	{
		var stats:Stats = e.fetch(Stats);
		if (null == stats) throw new Error("Status requires a Stats component");
		entityList.push(e);
		e.destructionListener(function(e:Entity) { remove(e); } );
		statsList.push(stats);
	}
	
	public function remove(e:Entity):Void 
	{
		statsList.remove(e.fetch(Stats));
		entityList.remove(e);
	}
	
}