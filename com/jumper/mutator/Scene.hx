package com.jumper.mutator;

import com.jumper.model.Pos;
import com.jumper.model.View;
import nme.display.Sprite;
import nme.Lib;
import com.jumper.Entity;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Scene implements ISystem
{
	private var posList:Array < Pos >;
	private var viewList:Array < View >;
	
	private var camPos:Pos;
	private var camView:View;
	
	private var scenePos:Pos;
	
	private var root:Sprite;
	
	public function new(root:Sprite) 
	{
		posList = new Array< Pos >();
		viewList = new Array< View >();
		scenePos = new Pos();
		
		this.root = root;
	}
	
	public function update(time:Float):Void {
		var current:Int = 0;

		while (current < posList.length) {
			var pos  = posList[current];
			var view = viewList[current];
			view.x = pos.pos.m_x;
			view.y = pos.pos.m_y;
			view.scaleX = (pos.vel.m_x < 0) ? -1 : 1;
			
			current++;
		}
	}
	public function add(e:Entity):Void {
		//nodes.push(node);
		e.destructionListener(function(e:Entity) { remove(e); } );
		if (e.id == 1) {
			camPos = e.fetch(Pos);
			camView = e.fetch(View);
		}else {
			viewList.push( e.fetch(View) );
			posList.push ( e.fetch(Pos) );
		}
		root.addChild(e.fetch(View));
		
	}
	public function remove(e:Entity):Void {
		posList.remove(e.fetch(Pos));
		var v:View = e.fetch(View);
		root.removeChild(v);
		viewList.remove(v);
	}
	
}