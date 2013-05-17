package com.jumper.mutator;

import com.jumper.ISystem;
import com.jumper.model.Stats;
import com.jumper.Entity;
import com.jumper.EpicGameJam;

using Lambda;
/**
 * ...
 * @author gback
 */

class Status implements ISystem
{
	
	private var statsList:Array<Stats>;
	private var entityList:Array<Entity>;
	
	public function new() 
	{
		statsList = new Array<Stats>();
		entityList = new Array<Entity>();
	}
	
	/* INTERFACE com.jumper.ISystem */
	
	public function update(time:Float):Void 
	{
		for (stat in statsList) {
			if(stat.health < 1) EpicGameJam.engine.
		}
		
	}
	
	public function add(e:Entity):Void 
	{
		statsList.push(e.fetch(Stats));
	}
	
	public function remove(e:Entity):Void 
	{
		var entityStat:Stats = e.fetch(Stats);
		statsList = Lambda.filter(statsList, function(stat) { return stat != entityStat } ).toArray();
	}
	
}