package com.slot.fruitBar.view.ui
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**游戏里面彩金栏的中奖图案*/
	public class InGameJPPattern extends Sprite
	{
		public function InGameJPPattern(patternId:int)
		{
			drawScene(patternId);
		}
		
		private function drawScene(patternId:int):void
		{
			var bgImage:Image = new Image(Assets.getTextureAtlas().getTexture("rect"));
			bgImage.touchable = false;
			addChild(bgImage);
			
			var patternImage:Image = new Image(Assets.getTextureAtlas().getTexture("pattern-" + (patternId < 10 ? "0"+patternId : patternId)));
			patternImage.scaleX = patternImage.scaleY = 0.2;
			patternImage.x = (bgImage.width - patternImage.width) * 0.5;
			patternImage.y = (bgImage.height - patternImage.height) * 0.5;
			patternImage.touchable = false;
			addChild(patternImage);
			
			touchable = false;
			flatten();
		}
	}
}