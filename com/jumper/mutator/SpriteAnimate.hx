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
import com.jumper.model.SpriteData;

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
	
	var tileSheets:Xml;
	
	var spriteDataCollection:Array<SpriteData>;

	public function new(root:Sprite) 
	{
		this.root = root;
		spriteAnimList = new Array<SpriteAnim>();
		viewList = new Array<View>();
		posList = new Array<Pos>();
		timeTilNextUpdate = .2;
		
		var tileConStr = Assets.getText("assets/tileSheetConfig.xml");
		var tileXml:Xml = Xml.parse(tileConStr);
		trace(tileXml.elements().next().nodeName);
		trace(tileXml.elements().next().elements().next().nodeName);
		tileSheets = tileXml.elements().next();
		var walkTile:Xml = tileXml.elements().next().elementsNamed("male_walk").next();
		
		spriteDataCollection = SpriteData.createSpriteData(tileConStr);
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
			//trace(" frame " + sprAnim.currentFrame);
			//TODO get anim sequence from tilesheets XML!!!!!!!!!!!!!!!
			var spriteData:SpriteData = getSpriteDataByName(sprAnim.sheetName);
			var animData:AnimData = spriteData.getAnimByName(sprAnim.animName);
			
			spriteData.tileSheet.drawTiles(root.graphics, [pos.pos.m_x - (animData.width/2), pos.pos.m_y - (animData.height/2), sprAnim.currentFrame]);
			if (updateAnimationFrame) {
				sprAnim.currentFrame++;
				trace("currentFrame: " + sprAnim.currentFrame);
				if (sprAnim.currentFrame > animData.frameIds[animData.frameIds.length-1]) sprAnim.currentFrame = animData.frameIds[0];
			}
			
			//debug points
			root.graphics.beginFill(0xff0000);
			root.graphics.drawCircle(pos.pos.m_x, pos.pos.m_y, 2);
			root.graphics.beginFill(0xffff00);
			root.graphics.drawCircle(pos.pos.m_x - pos.halfExtents.m_x, pos.pos.m_y - pos.halfExtents.m_y, 2);
			
			current++;
		}
	}
	
	function getSpriteDataByName(sheetName:String):SpriteData {
		return Lambda.filter(spriteDataCollection, function(sprData) {
			return sprData.sheetName == sheetName;
		}).first();
	}
	
	public function add(e:Entity):Void 
	{
		var spriteAnim:SpriteAnim = e.fetch(SpriteAnim);
		var view:View = e.fetch(View);
		var maleSheetImg:BitmapData = Assets.getBitmapData("assets/maleSheet.png");
		trace("male sheet " + maleSheetImg);
		/*var tileSheet:Tilesheet = new Tilesheet(maleSheetImg);
		//tileSheet.addTileRect(new Rectangle(0, 0, 32, 64));
		//tileSheet.addTileRect(new Rectangle(32, 0, 32, 64));
		var i:Int = 0;
		while (i < 7)
		{
			tileSheet.addTileRect(new Rectangle(i*32,0,32,64));
			i++;
		}
		
		spriteAnim.tileSheet = tileSheet;*/
		
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