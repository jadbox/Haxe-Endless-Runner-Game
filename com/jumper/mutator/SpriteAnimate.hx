package com.jumper.mutator;

import nme.display.BitmapData;
import com.jumper.ISystem;
import com.jumper.model.SpriteAnim;
import com.jumper.Entity;
import com.jumper.model.View;
import nme.display.Sprite;
import nme.display.Tilesheet;
import nme.Assets;
import nme.geom.Rectangle;
import com.jumper.model.Pos;

/**
 * ...
 * @author gback
 */

class SpriteAnimate implements ISystem
{
	var spriteAnimList:Array<SpriteAnim>;
	var viewList:Array<View>;
	var posList:Array<Pos>;
	
	var timeTilNextUpdate:Float;
	
	var root:Sprite;

	public function new(root:Sprite) 
	{
		this.root = root;
		spriteAnimList = new Array<SpriteAnim>();
		viewList = new Array<View>();
		posList = new Array<Pos>();
		timeTilNextUpdate = .2;
	}
	
	/* INTERFACE com.jumper.ISystem */
	
	public function update(time:Float):Void 
	{
		//clear the stage
		root.graphics.clear();
		
		var updateAnimationFrame:Bool = false;
		
		var current:Int = 0;
		if (timeTilNextUpdate > 0) {
			timeTilNextUpdate -= time;
		}else {
			timeTilNextUpdate = .2;
			updateAnimationFrame = true;
		}
		while (current < spriteAnimList.length) {
			var sprAnim:SpriteAnim = spriteAnimList[current];
			var view:View = viewList[current];
			var pos:Pos = posList[current];
			view.graphics.clear();
			trace(" frame " + sprAnim.currentFrame);
			sprAnim.tileSheet.drawTiles(root.graphics, [pos.pos.m_x - pos.halfExtents.m_x, pos.pos.m_y - pos.halfExtents.m_y, sprAnim.currentFrame]);
			if (updateAnimationFrame) {
				sprAnim.currentFrame++;
				if (sprAnim.currentFrame > 6) sprAnim.currentFrame = 1;
			}
			
			
			current++;
		}
	}
	
	public function add(e:Entity):Void 
	{
		var spriteAnim:SpriteAnim = e.fetch(SpriteAnim);
		var view:View = e.fetch(View);
		var maleSheetImg:BitmapData = Assets.getBitmapData("assets/maleSheet.png");
		trace("male sheet " + maleSheetImg);
		var tileSheet:Tilesheet = new Tilesheet(maleSheetImg);
		//tileSheet.addTileRect(new Rectangle(0, 0, 32, 64));
		//tileSheet.addTileRect(new Rectangle(32, 0, 32, 64));
		var i:Int = 0;
		while (i < 7)
		{
			tileSheet.addTileRect(new Rectangle(i*32,0,32,64));
			i++;
		}
		
		spriteAnim.tileSheet = tileSheet;
		
		spriteAnimList.push(spriteAnim);
		viewList.push(view);
		posList.push(e.fetch(Pos));
	}
	
	public function remove(e:Entity):Void 
	{
		spriteAnimList.remove(e.fetch(SpriteAnim));
		viewList.remove(e.fetch(View));
	}
	
}