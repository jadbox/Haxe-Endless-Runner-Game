package com.jumper.mutator;

import model.DisplayNode;
import model.Pos;
import model.View;
import nme.display.Sprite;
import nme.Lib;

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
	static var camCenter:Int;
	
	private var scenePos:Pos;
	
	private var root:Sprite;
	
	public function new(root:Sprite) 
	{
		posList = new Array< Pos >();
		viewList = new Array< View >();
		scenePos = new Pos();
		camCenter = Std.int(Lib.current.stage.stageWidth / 2);
		
		this.root = root;
	}
	
	public function update(time:Float):Void {
		var current:Int = 0;
		/*if (null != camPos) {
			if (camPos.x > camCenter || camPos.x < camCenter)
			{
				scenePos.x += camPos.x - camCenter;
				camPos.x = camCenter;
			}
			camView.x = camPos.x;
			camView.y = camPos.y;
		}*/
		while (current < posList.length) {
			var pos  = posList[current];
			var view = viewList[current];
			view.x = pos.pos.m_x;
			view.y = pos.pos.m_y;
			current++;
		}
	}
	public function add(e:Entity):Void {
		//nodes.push(node);
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
		
	}
	
}