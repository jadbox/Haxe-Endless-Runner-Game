package com.jumper.model;
import nme.display.Tilesheet;
import nme.Assets;

/**
 * ...
 * @author Greg
 */

class SpriteData 
{
    public var tileSheet:Tilesheet;
    public var animationId:Int;
    public var animationName:String;
    
    static public function createSpriteData(spriteDataLocation:String):Array<SpriteData>
    {
        var spriteDataArray:Array<SpriteData> = new Array<SpriteData>();
        
        var spritesRaw:String = Assets.getText(spriteDataLocation);
		trace("level: " + spritesRaw);
		var sprites:Xml = Xml.parse(spritesRaw);
		//trace(level);
		trace(sprites.elements().next() );
		trace(sprites.elements().next().elements().next().firstChild().nodeValue);
		var tilesheetNode:Xml = sprites.elements().next().elementsNamed("tilesheet").next();
		var animationNode:Xml = tilesheetNode.elementsNamed("animation").next();
        
        
        return spriteDataArray;
    }
    
    
    public function new() 
    {
        
    }
    
}