package com.slot.fruitBar.view.ui
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class InGameJP extends Sprite
	{
		public function InGameJP()
		{
			drawScene();
		}
		
		private function drawScene():void
		{
			var titleChar1:Image = new Image(Assets.getTextureAtlas().getTexture("jpString-02"));
			titleChar1.touchable = false;
			addChild(titleChar1);
			
			var jpbar:JPItem = new JPItem();
			jpbar.y = titleChar1.y + titleChar1.height + 5;
			addChild(jpbar);
			
			titleChar1.x = (jpbar.width - titleChar1.width) * 0.5;
			
			var titleChar2:Image = new Image(Assets.getTextureAtlas().getTexture("jpString"));
			titleChar2.touchable = false;
			titleChar2.y = jpbar.y + jpbar.height + 10;
			titleChar2.x = titleChar1.x;
			addChild(titleChar2);
			
			var jpbar2:JPItem = new JPItem();
			jpbar2.y = titleChar2.y + titleChar2.height + 5;
			addChild(jpbar2);
			
			var jpPattern:InGameJPPattern;
			
			var i:int;
			
			for(i = 0; i < 3; i++)
			{
				jpPattern = new InGameJPPattern(0);
				jpPattern.y = jpbar2.y + 40;
				jpPattern.x = titleChar2.x + i * (jpPattern.width + 1);
				addChild(jpPattern);
			}
			
			var jpbar3:JPItem = new JPItem();
			jpbar3.y = jpPattern.y + jpPattern.height + 5;
			addChild(jpbar3);
			
			for(i = 0; i < 3; i++)
			{
				jpPattern = new InGameJPPattern(1);
				jpPattern.y = jpbar3.y + 40;
				jpPattern.x = titleChar2.x + i * (jpPattern.width + 1);
				addChild(jpPattern);
			}
			
			var jpbar4:JPItem = new JPItem();
			jpbar4.y = jpPattern.y + jpPattern.height + 5;
			addChild(jpbar4);
			
			var line:Image = new Image(Assets.getTexture("JPLINE",true));
			line.touchable = false;
			line.scaleY = 0.6;
			line.x = -10;
			line.y = jpbar4.y + 40;
			addChild(line);
			
			var fever:Image = new Image(Assets.getTextureAtlas().getTexture("feverGameString"));
			fever.touchable = false;
			fever.y = line.y + 20;
			addChild(fever);
			
			for(i = 0; i < 3; i++)
			{
				jpPattern = new InGameJPPattern(5);
				jpPattern.y = fever.y + 30;
				jpPattern.x =  i * (jpPattern.width + 1);
				addChild(jpPattern);
			}
			
			var txt1:TextField = new TextField(100,30,"4 / 7","Verdana",18,0xffff00,true);
			txt1.touchable = false;
			txt1.y = jpPattern.y;
			txt1.x = 100;
			addChild(txt1);
			
			for(i = 0; i < 2; i++)
			{
				jpPattern = new InGameJPPattern(9);
				jpPattern.y = fever.y + 70;
				jpPattern.x =  18 + i * (jpPattern.width + 1);
				addChild(jpPattern);
			}
			
			var txt2:TextField = new TextField(100,30,"10 / 15","Verdana",18,0xffff00,true);
			txt2.touchable = false;
			txt2.hAlign = HAlign.LEFT;
			txt2.y = jpPattern.y;
			txt2.x = 100;
			addChild(txt2);
			
			touchable = false;
			flatten();
		}
	}
}