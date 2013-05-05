package com.jumper;

import com.jumper.level.Map;
import com.jumper.maths.Vector2;
import com.jumper.level.TileTypes;
import com.jumper.model.Pos;
import com.jumper.maths.Vector2;
import nme.display.Bitmap;
import nme.display.MovieClip;
import nme.display.Sprite;
import com.jumper.model.View;
import nme.Assets;

class LevelBuilder
{
	var gameEngine:Engine;
	var map:Map;
	
	public function new(engine:Engine)
	{
		gameEngine = engine;
	}
	
	public function constructLevel(map:Map):Void
	{
		for (i in 0...map.mapBlocks.length)
		{
			CreateTilesInner(map.mapBlocks[i], i);
		}
	}
	
	private function CreateTilesInner( tileSet:Array<Int>, block:Int = 0, addtoScene:Bool=true ):Void
	{
		var index:Int = 0;
		for ( tileCode in tileSet )
		{
			var tile:MovieClip = null;
			
			// calculate the position of each tile: 0,0 maps to Constants.kWorldHalfExtents
			var tileI:Int = Std.int(index%Map.m_Width);
			var tileJ:Int = Std.int(index/Map.m_Width);
			
			var tileX:Int = Std.int(Map.TileCoordsToWorldX(tileI)) + (Map.m_Width * Constants.kTileSize * block);
			var tileY:Int = Std.int(Map.TileCoordsToWorldY(tileJ));
			
			var tilePos:Vector2 = new Vector2( tileX, tileY );
			
			// create each tile
			switch ( tileCode )
			{
				//
				// foreground tiles
				//
				case TileTypes.kEmpty:
					tile = null;
				case TileTypes.kPlatform:
				{
					tile = new MovieClip( );
					tile.graphics.beginFill( 0xff0000 );
					tile.graphics.drawRect( 0, 0, Constants.kTileSize, Constants.kTileSize );
					tile.graphics.endFill( );
				}
				//
				// characters
				//
				case TileTypes.kPlayer:
				{
					if(block == 0){
					gameEngine.addEntity(gameEngine.player = new Entity());
					var playerPos:Pos = new Pos();
					playerPos.pos = tilePos;
					var playerView:View = new View();
					var playerSprite:Sprite = new Sprite();
					gameEngine.player.set([playerPos, playerView]);
					playerSprite.graphics.beginFill(0x00ff00);
					playerSprite.graphics.drawRect(0, 0, Constants.kPlayerWidth, Constants.kPlayerHeight);
					playerSprite.x -= Constants.kPlayerWidth / 2;
					playerSprite.y -= Constants.kPlayerHeight / 2;
					playerView.addChild(playerSprite);
					var charBmp:Bitmap = new Bitmap(Assets.getBitmapData("assets/uglyduck.png"));
					playerSprite.addChild(charBmp);
					//charBmp.y -= charBmp.height / 2;
					
					gameEngine.playerMovement.add(gameEngine.player);
					gameEngine.scene.add(gameEngine.player);
					}
					//tile = new MovieClip();
					//tile.addChild(playerView);
					//tile = m_player = new Player();
					//m_player.Initialise(tilePos, map, EpicGameJam.gameJam);
					//m_player.addChild(playerView);
					//playerView.x -= Constants.kPlayerWidth / 2;
					//playerView.y -= Constants.kPlayerWidth / 2;
					//tilePos = m_player.m_Pos;
					
				}
				case TileTypes.kEnemy:
					var enemy:Entity = new Entity();
					gameEngine.addEntity(enemy);
					var enemyPos:Pos = new Pos();
					enemyPos.pos = tilePos;
					var enemyView:View = new View();
					var enemySprite:Sprite = new Sprite();
					enemy.set([enemyPos, enemyView]);
					enemySprite.graphics.beginFill(0xffff00);
					enemySprite.graphics.drawRect(0, 0, 16, 16);
					enemySprite.x -= 8;
					enemySprite.y -= 8;
					enemyView.addChild(enemySprite);
					
					gameEngine.enemyMovement.add(enemy);
					gameEngine.scene.add(enemy);
					
				default: Util.Assert( false, "Unexpected tile code " + tileCode );
			}
			
			if ( tile!=null )
			{
				tile.x = tilePos.m_x;
				tile.y = tilePos.m_y;
				tile.cacheAsBitmap = true;
				
				if ( addtoScene )
				{
					gameEngine.addChild( tile );
				}
			}
			
			index++;
		}
	}

}

