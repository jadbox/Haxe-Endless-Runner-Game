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
	//draws debug rects for animations
	private static inline var IsDebug:Bool = true;
	
	var spriteAnimList:Array<SpriteAnim>;
	var viewList:Array<View>;
	var posList:Array<Pos>;
	
	var timeTilNextUpdate:Float;
	
	var root:Sprite;
	
	var tileSheets:Xml;
	
	var spriteDataCollection:Array<SpriteData>;
	
	private var curPos:Pos;
	private var curSpriteAnim:SpriteAnim;
	private var curView:View;

	public function new(root:Sprite) 
	{
		this.root = root;
		spriteAnimList = new Array<SpriteAnim>();
		viewList = new Array<View>();
		posList = new Array<Pos>();
		timeTilNextUpdate = .1;
		
		var tileConStr = Assets.getText("assets/tileSheetConfig.xml");
		
		spriteDataCollection = SpriteData.createSpriteData(tileConStr);
	}
	
	/* INTERFACE com.jumper.ISystem */
	
	public function update(time:Float):Void 
	{
		//clear the stage
		//root.graphics.clear();
		
		var updateAnimationFrame:Bool = false;
		
		var current:Int = 0;
		if (timeTilNextUpdate > 0) {
			timeTilNextUpdate -= time;
		}else {
			timeTilNextUpdate = .1;
			updateAnimationFrame = true;
		}
		while (current < spriteAnimList.length) {
			curSpriteAnim = spriteAnimList[current];
			curView = viewList[current];
			curPos = posList[current];
			curView.graphics.clear();
			//set animation sequences based on game state
			setAnimations();
			
			
			//trace(" frame " + sprAnim.currentFrame);
			var spriteData:SpriteData = getSpriteDataByName(curSpriteAnim.sheetName);
			var animData:AnimData = spriteData.getAnimByName(curSpriteAnim.animName);
			
			spriteData.tileSheet.drawTiles(root.graphics, [curPos.pos.m_x, curPos.pos.m_y, curSpriteAnim.currentFrame, curPos.scale], false, Tilesheet.TILE_SCALE);
			if (updateAnimationFrame) {
				curSpriteAnim.currentFrame++;
				//trace("currentFrame: " + curSpriteAnim.currentFrame);
				if (curSpriteAnim.currentFrame > animData.frameIds[animData.frameIds.length-1] || curSpriteAnim.currentFrame < animData.frameIds[0]) curSpriteAnim.currentFrame = animData.frameIds[0];
			}
			
			//debug points
			if (IsDebug) {
				//Pos x,y
				root.graphics.beginFill(0xff0000);
				root.graphics.drawCircle(curPos.pos.m_x, curPos.pos.m_y, 2);
				//Half Extents x,y
				root.graphics.beginFill(0xffff00);
				root.graphics.drawCircle(curPos.pos.m_x - curPos.halfExtents.m_x, curPos.pos.m_y - curPos.halfExtents.m_y, 2);
				//animation Pos x,y
				root.graphics.beginFill(0x00ffff);
				root.graphics.drawCircle(curPos.pos.m_x - (animData.width / 2) * curPos.scale, curPos.pos.m_y - (animData.height / 2) * curPos.scale, 2);
				//animation rect
				root.graphics.beginFill(0x000fff, .4);
				root.graphics.drawRect(curPos.pos.m_x - (animData.width / 2) * curPos.scale, curPos.pos.m_y - (animData.height / 2) * curPos.scale, animData.width * curPos.scale, animData.height * curPos.scale);
				//collider rect
				root.graphics.beginFill(0x0000ff, .5);
				var bounds:Rectangle = curPos.getBounds();
				root.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
			}
			current++;
		}
	}
	//override me
	private function setAnimations(){}
	
	function getSpriteDataByName(sheetName:String):SpriteData {
		return Lambda.filter(spriteDataCollection, function(sprData) {
			return sprData.sheetName == sheetName;
		}).first();
	}
	
	public function add(e:Entity):Void 
	{
		var spriteAnim:SpriteAnim = e.fetch(SpriteAnim);
		var view:View = e.fetch(View);
		
		spriteAnimList.push(spriteAnim);
		viewList.push(view);
		var pos:Pos = e.fetch(Pos);
		var spriteData:SpriteData = getSpriteDataByName(spriteAnim.sheetName);
		pos.setExtents(spriteData.collider.width, spriteData.collider.height);
		posList.push(pos);
	}
	
	public function remove(e:Entity):Void 
	{
		spriteAnimList.remove(e.fetch(SpriteAnim));
		viewList.remove(e.fetch(View));
	}
	
}