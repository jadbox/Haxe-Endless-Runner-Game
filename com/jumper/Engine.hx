package com.jumper;

import com.jumper.mutator.EnemyMove;
import nme.display.MovieClip;
import nme.display.Graphics;
import nme.display.Sprite;

import com.jumper.model.Pos;
import com.jumper.model.View;
import com.jumper.mutator.Collision;
import com.jumper.mutator.PlayerMove;
import com.jumper.mutator.Scene;

import com.jumper.mutator.Move;
import com.jumper.level.Map;

import com.jumper.maths.Vector2;
import com.jumper.level.TileTypes;
import com.jumper.pools.VectorPool;

using Lambda;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Engine extends MovieClip
{
	private var systems:Array<ISystem>;
	public var scene:Scene;
	public var movement:Move;
	public var playerMovement:PlayerMove;
	public var enemyMovement:EnemyMove;
	public var collision:Collision;
	
	public var map:Map;
	
	public var player:Entity;
	
	private var entities:Array<Entity>;
	
	private var m_player:MoveableObject;
	private var m_camera:Camera;
	
	
	
	public function new() 
	{
		super();
		trace("hi engine");
		
		map = new Map(this);
		
		systems = new Array<ISystem>();
		entities = new Array<Entity>();
		//we will refactor this
		//enemies = new Array<Entity>();
		
		addSystem(scene = new Scene(this));
		addSystem(enemyMovement = new EnemyMove(map, EpicGameJam.gameJam));
		addSystem(playerMovement = new PlayerMove(map, EpicGameJam.gameJam));
		addSystem(collision = new Collision());
		
		var lvlBuild:LevelBuilder = new LevelBuilder(this);
		lvlBuild.constructLevel(map);
		//CreateTilesInner(map.m_map);
		
		m_camera = new Camera(this, player.fetch(Pos));
		
	}
	
	
	
	public function addEntity(entity:Entity):Void {
		entities.push(entity);
	}
	
	public function addSystem(system:ISystem):Void {
		systems.push(system);
	}
	/*public function removeEntity(entity:Entity):Void {
		
	}*/
	
	public function getEntitiesById(entityId:Int):Array<Entity>
	{
		return entities.filter(function(e:Entity):Bool {
			if (e.id == entityId) return true;
			return false;
		}).array();
	}
	public function update(time:Float):Void {
		for (s in systems) s.update(time);
		//m_player.Update(time);
		m_camera.Update(time);
	}
}