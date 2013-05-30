package com.jumper.model;
import nme.display.Tilesheet;
import nme.Assets;
import nme.geom.Rectangle;

using Lambda;

/**
 * ...
 * @author Greg
 */

 typedef AnimData = {
	 //public var id:Int;
	 public var name:String;
	 public var x:Float;
	 public var y:Float;
	 public var width:Float;
	 public var height:Float;
	 //the frame ids as assigned by the tilesheet
	 public var frameIds:Array<Int>;
 }
 
 typedef ColliderData = {
	public var xOffset:Float;
	public var yOffset:Float;
	public var width:Float;
	public var height:Float;
 }
 
class SpriteData 
{
	public var sheetName:String;
    public var tileSheet:Tilesheet;
    public var animations:Array<AnimData>;
	public var collider:ColliderData;
    
    static public function createSpriteData(spriteDataRaw:String):Array<SpriteData>
    {
        var spriteDataArray:Array<SpriteData> = new Array<SpriteData>();

		var sprites:Xml = Xml.parse(spriteDataRaw);
		//trace(level);
		trace(sprites.elements().next() );
		trace(sprites.elements().next().elements().next().firstChild().nodeValue);
		var tilesheetNode:Xml = sprites.elements().next().elementsNamed("tilesheet").next();
		trace(tilesheetNode);
		var animationNode:Xml = tilesheetNode.elementsNamed("anim").next();
		trace(animationNode);
		var tileSheetsNode:Xml = sprites.elements().next();
		for ( ts in tileSheetsNode.elementsNamed("tilesheet")) 
		{
			trace(ts.get("dir"));
			var spriteData:SpriteData = new SpriteData(new Tilesheet(Assets.getBitmapData(ts.get("dir"))));
			spriteData.sheetName = ts.get("name");
			var idCount:Int = 0;
			spriteDataArray.push(spriteData);
			var colliderElement:Xml = ts.elementsNamed("collider").next();
			spriteData.collider = {
				xOffset:Std.parseFloat(colliderElement.get("xOffset")),
				yOffset:Std.parseFloat(colliderElement.get("yOffset")),
				width:Std.parseFloat(colliderElement.get("width")),
				height:Std.parseFloat(colliderElement.get("height"))
			}
			
			for (anim in ts.elementsNamed("anim")) {
				trace(anim);
				//spriteData.tileSheet.drawTiles
				
				var animData:AnimData = {
					name:anim.get("name"),
					x:Std.parseFloat(anim.get("x")),
					y:Std.parseFloat(anim.get("y")),
					width:Std.parseFloat(anim.get("width")),
					height:Std.parseFloat(anim.get("height")),
					frameIds:new Array<Int>()
				};
				var frameCount:Int = Std.parseInt(anim.get("frames"));
				var i:Int = 0;
				while ( i < frameCount) {
					spriteData.tileSheet.addTileRect(new Rectangle(animData.x + animData.width * i, animData.y, animData.width, animData.height));
					animData.frameIds.push(i+idCount);
					i++;
				}
				idCount += frameCount;
				spriteData.animations.push(animData);
				trace(animData.name + " , " + animData.frameIds + " , idCount: " + idCount);
			}
		}
        
        
        return spriteDataArray;
    }
    
    
    public function new(tileSheet:Tilesheet) 
    {
        this.tileSheet = tileSheet;
		animations = new Array<AnimData>();
    }
	
	public function getAnimByName(animName:String):AnimData {
		return animations.filter(function(animData) {
			return animData.name == animName;
		}).first();
	}
    
}