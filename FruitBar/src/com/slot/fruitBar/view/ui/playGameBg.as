package com.slot.fruitBar.view.ui
{
	import com.slot.fruitBar.view.View;
	
	import starling.display.Image;
	import starling.text.TextField;
	
	/**游戏中的背景*/
	public class playGameBg extends View
	{
		public function playGameBg()
		{
			drawScene();
		}
		
		override protected function drawScene():void
		{
			var bgImage:Image = new Image(Assets.getTexture("PLAYGAMEBG",true));
			bgImage.touchable = false;
			addChild(bgImage);
			
			var betRateChar:Image = new Image(Assets.getTextureAtlas().getTexture("betRateString"));
			betRateChar.touchable = false;
			betRateChar.x = 35;
			betRateChar.y = 632;
			addChild(betRateChar);
			
			var betRateTextfieldBg:Image = new Image(Assets.getTextureAtlas().getTexture("textfieldBg"));
			betRateTextfieldBg.touchable = false;
			betRateTextfieldBg.y = 627;
			betRateTextfieldBg.x = betRateChar.x + betRateChar.width + 10;
			addChild(betRateTextfieldBg);
			
			var scoreChar:Image = new Image(Assets.getTextureAtlas().getTexture("scoreString"));
			scoreChar.touchable = false;
			scoreChar.x = 260;
			scoreChar.y = 632;
			addChild(scoreChar);
			
			var scoreTextfieldBg:Image = new Image(Assets.getTextureAtlas().getTexture("textfieldBg"));
			scoreTextfieldBg.touchable = false;
			scoreTextfieldBg.y = 627;
			scoreTextfieldBg.x = scoreChar.x + scoreChar.width + 10;
			addChild(scoreTextfieldBg);
			
			var betChar:Image = new Image(Assets.getTextureAtlas().getTexture("betMarkString"));
			betChar.touchable = false;
			betChar.x = 500;
			betChar.y = 632;
			addChild(betChar);
			
			var betTextfieldBg:Image = new Image(Assets.getTextureAtlas().getTexture("textfieldBg"));
			betTextfieldBg.touchable = false;
			betTextfieldBg.y = 627;
			betTextfieldBg.x = betChar.x + betChar.width + 10;
			addChild(betTextfieldBg);
			
			var totalMarkChar:Image = new Image(Assets.getTextureAtlas().getTexture("totalMarkString"));
			totalMarkChar.touchable = false;
			totalMarkChar.x = 740;
			totalMarkChar.y = 632;
			addChild(totalMarkChar);
			
			var totalMarkTextfieldBg:Image = new Image(Assets.getTextureAtlas().getTexture("textfieldBg"));
			totalMarkTextfieldBg.touchable = false;
			totalMarkTextfieldBg.y = 627;
			totalMarkTextfieldBg.x = totalMarkChar.x + totalMarkChar.width + 10;
			addChild(totalMarkTextfieldBg);
			
			var startFieldBg:Image = new Image(Assets.getTextureAtlas().getTexture("infoBorder-01"));
			startFieldBg.touchable = false;
			startFieldBg.x = 462;
			startFieldBg.y = 663;
			addChild(startFieldBg);
			
			var startChar:TextField = new TextField(36,50,"启动\n次数","arial",16,0xffffff);
			startChar.touchable = false;
			startChar.x = 470;
			startChar.y = 663;
			addChild(startChar);
			
			this.touchable = false;
			this.flatten();
		}
		
		override public function dealloc():void
		{
			unflatten();
			
			var child:*;
			while(numChildren > 0)
			{
				child = getChildAt(0);
				if(child as Image)
				{
					(child as Image).texture.dispose();
				}
				child.removeFromParent(true);
			}
			super.dealloc();
		}
	}
}